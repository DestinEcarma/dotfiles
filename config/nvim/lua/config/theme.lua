local state = {
	lazy_ready = false,
	restoring = false,
}

local theme_file = vim.fn.stdpath("state") .. "/theme.txt"
local group = vim.api.nvim_create_augroup("ThemePersistence", { clear = true })

---Read the saved colorscheme from disk.
---@return string|nil theme
local function read_theme()
	local file = io.open(theme_file, "r")
	if not file then return nil end

	local theme = file:read("*a")
	file:close()

	theme = theme and theme:gsub("%s+", "") or ""
	return theme ~= "" and theme or nil
end

---Write a colorscheme name to disk.
---@param theme string
local function write_theme(theme)
	local file = io.open(theme_file, "w")
	if not file then return end

	file:write(theme)
	file:close()
end

---Return whether the theme should be persisted.
---@param theme string|nil
---@return boolean
local function is_persistable(theme) return theme ~= nil and theme ~= "" and theme ~= "habamax" and theme ~= "default" end

-- Auto save color scheme
vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	callback = function(args)
		-- Ignore temporary changes during startup/restore.
		if not state.lazy_ready or state.restoring then return end

		local theme = vim.g.colors_name or args.match
		if not is_persistable(theme) then return end

		write_theme(theme)
	end,
})

-- Auto restore color scheme
vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "LazyDone",
	once = true,
	callback = function()
		state.lazy_ready = true
		state.restoring = true

		vim.schedule(function()
			local theme = read_theme()
			if theme then pcall(vim.cmd.colorscheme, theme) end

			state.restoring = false
		end)
	end,
})
