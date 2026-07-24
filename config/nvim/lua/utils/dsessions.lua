---@module "snacks"

---@class SessionItem
---@field text string Display text (prefix + filename) for the picker
---@field file string Absolute path to the session file
---@field prefix string Directory prefix, "~"-shortened
---@field filename string Basename of the tracked project path

---@class SessionsConfig
---@field session_dir? string Directory where session files are stored
---@field max_age_days? integer Sessions older than this are pruned automatically

---@class SessionsModule
---@field config SessionsConfig
local M = {}

M.config = {
	session_dir = vim.fn.stdpath("state") .. "/sessions/",
	max_age_days = 30,
}

local uv = vim.loop or vim.uv
-- Escape any literal "%" in **$HOME** so it is safe to use inside gsub patterns.
local home = (os.getenv("HOME") or ""):gsub("%%", "%%%%")

--- Initializes the module: creates the session directory and merges user options.
---@param opts? SessionsConfig
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
	local ok, err = pcall(vim.fn.mkdir, M.config.session_dir, "p")
	if not ok then
		vim.notify("sessions.nvim: failed to create session dir: " .. tostring(err), vim.log.levels.ERROR)
	end
end

--- Computes the session file path for the current working directory.
---@return string path Absolute path to the **.vim** session file for cwd
function M.session_path()
	local cwd = vim.fn.getcwd()
	-- Encode path separators as "%" so the cwd can be embedded in a flat filename.
	local name = cwd:gsub("[/\\:]", "%%")
	return M.config.session_dir .. name .. ".vim"
end

--- Prompts the user and deletes selected session(s) from a Snacks picker.
---@param picker snacks.Picker Snacks picker instance
---@param item? snacks.picker.Item Fallback single item if nothing is multi-selected
local function delete_session(picker, item)
	local items = picker:selected()
	if not items or vim.tbl_isempty(items) then
		item = item or picker:selected({ fallback = true })
		items = item and { item } or {}
	end

	if vim.tbl_isempty(items) then
		return
	end

	vim.ui.select({ "Yes", "No" }, {
		prompt = ("Delete %d session(s)?"):format(#items),
	}, function(choice)
		if choice ~= "Yes" then
			return
		end

		for _, entry in ipairs(items) do
			if entry.file then
				vim.fn.delete(entry.file)
			end
		end

		Snacks.notify.info(("Deleted %d session(s)"):format(#items), {
			id = "session",
			title = "Session",
		})

		picker:refresh()
	end)
end

--- Removes session files older than a given number of days.
---@param max_age_days? integer Defaults to `M.config.max_age_days`
function M.delete_old_sessions(max_age_days)
	max_age_days = max_age_days or M.config.max_age_days
	local now = os.time()
	local max_age_seconds = max_age_days * 24 * 60 * 60

	local fd = uv.fs_scandir(M.config.session_dir)
	if not fd then
		return
	end

	while true do
		local name, ftype = uv.fs_scandir_next(fd)
		if not name then
			break
		end

		-- Skip anything that isn't a *.vim file (fixes original inverted logic).
		if ftype ~= "file" or not name:match("%.vim$") then
			goto continue
		end

		local path = M.config.session_dir .. name
		local stat = uv.fs_stat(path)

		if stat and stat.mtime and (now - stat.mtime.sec) > max_age_seconds then
			uv.fs_unlink(path)
		end

		::continue::
	end
end

--- Scans the session directory and builds picker-ready items, sorted by filename.
---@return SessionItem[] items
local function get_session_items()
	local items = {}
	local fd = uv.fs_scandir(M.config.session_dir)
	if not fd then
		return items
	end

	while true do
		local name, ftype = uv.fs_scandir_next(fd)
		if not name then
			break
		end

		if ftype == "file" and name:sub(-4) == ".vim" then
			local file = M.config.session_dir .. name
			local path = name:sub(1, -5):gsub("%%", "/")
			local filename = vim.fs.basename(path)
			local prefix = vim.fs.dirname(path)

			if prefix == "." then
				prefix = ""
			else
				prefix = prefix:gsub("^" .. home, "~") .. "/"
			end

			items[#items + 1] = {
				text = prefix .. filename,
				file = file,
				prefix = prefix,
				filename = filename,
			}
		end
	end

	table.sort(items, function(a, b)
		return a.filename < b.filename
	end)

	return items
end

--- Formats a session item for display in the Snacks picker.
---@param item SessionItem
---@return table[] segments List of `{text, highlight_group}` pairs
local function session_list_format(item)
	return {
		{ item.prefix, "SnacksPickerComment" },
		{ item.filename, "SnacksPickerLabel" },
	}
end

--- Opens the interactive session picker (list, delete via "dd", confirm to load).
function M.session_list()
	Snacks.picker.pick({
		source = "sessions",
		title = "Sessions",
		finder = get_session_items,
		format = session_list_format,
		actions = {
			delete_session = function(picker, item)
				delete_session(picker, item)
			end,
		},
		win = {
			list = {
				keys = {
					["dd"] = "delete_session",
				},
			},
		},
		confirm = function(picker, item)
			picker:close()
			if item and item.file then
				vim.cmd("silent! tabonly")
				vim.cmd("silent! only")
				vim.cmd("silent! %bwipeout!")
				M.restore_session(item.file)
			end
		end,
	})
end

--- Saves (via `:mksession`) the current session to session_path().
function M.save_session()
	local file = M.session_path()
	vim.cmd("mksession! " .. vim.fn.fnameescape(file))
	Snacks.notify.info("Session saved: " .. file, { id = "session", title = "Session" })
end

--- Restores the current directory from `file` or session_path().
---@param file string? Defaults to M.session_path()
function M.restore_session(file)
	file = file or M.session_path()
	vim.cmd("source " .. vim.fn.fnameescape(file))
	Snacks.notify.info("Session restored!", { id = "session", title = "Session" })
end

return M
