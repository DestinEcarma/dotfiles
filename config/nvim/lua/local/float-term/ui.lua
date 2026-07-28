local M = {}

local function set_win_opts(win)
	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
	vim.wo[win].statuscolumn = ""
	vim.wo[win].winfixbuf = true
	vim.wo[win].winhighlight =
		"Normal:FloatTermNormal,NormalNC:FloatTermNormalNC,NormalFloat:FloatTermFloat,FloatBorder:FloatTermBorder"
end

function M.open_term(buf, win)
	if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then return end

	vim.wo[win].winfixbuf = false
	vim.api.nvim_win_set_buf(win, buf)
	vim.wo[win].winfixbuf = true
end

function M.open_win(buf, opts)
	local float_opts = opts.float

	local width = float_opts.width or math.floor(vim.o.columns * 0.8)
	local height = float_opts.height or math.floor(vim.o.lines * 0.8)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = float_opts.row or math.floor((vim.o.lines - height) / 2 - 1),
		col = float_opts.col or math.floor((vim.o.columns - width) / 2),
		width = width,
		height = height,
		style = float_opts.style,
		border = float_opts.border,
		anchor = float_opts.anchor,
		focusable = float_opts.focusable ~= false,
		zindex = float_opts.zindex,
	})

	set_win_opts(win)

	if float_opts.backdrop then M.set_backdrop(win, float_opts) end
	if opts.terminal.auto_insert then vim.cmd("startinsert") end

	return win
end

function M.set_winbar(win_term)
	if not win_term or not win_term.win or not vim.api.nvim_win_is_valid(win_term.win) then return end

	local opts = win_term.opts
	local parts = {}

	for i, term in ipairs(win_term.terminals) do
		local hl_state = (i == win_term.active) and "Active" or "Inactive"
		local hl_tab = ("%%#FloatTermTab%s#"):format(hl_state)
		local hl_sep = ("%%#FloatTermTabSeparator%s#"):format(hl_state)

		parts[#parts + 1] = hl_sep .. opts.winbar.separator.left
		parts[#parts + 1] = ("%%%d@v:lua.___float_term.winbar_click@%s %d:%s %%T"):format(i, hl_tab, i, term.name or "")
		parts[#parts + 1] = hl_sep .. opts.winbar.separator.right
		parts[#parts + 1] = "%#FloatTermTabFill#"
	end

	vim.wo[win_term.win].winbar = table.concat(parts)
end

function M.set_backdrop(win, opts)
	local buf = vim.api.nvim_create_buf(false, true)
	local back_win = vim.api.nvim_open_win(buf, false, {
		relative = "editor",
		row = 0,
		col = 0,
		width = vim.o.columns,
		height = vim.o.lines,
		style = "minimal",
		focusable = false,
		zindex = opts.zindex - 1,
	})

	vim.wo[back_win].winhighlight = "Normal:FloatTermBackdrop"
	vim.wo[back_win].winblend = opts.backdrop

	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(win),
		once = true,
		callback = function()
			if vim.api.nvim_win_is_valid(back_win) then vim.api.nvim_win_close(back_win, true) end
		end,
	})
end

return M
