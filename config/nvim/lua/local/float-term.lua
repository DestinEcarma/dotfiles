local config = require("local.float-term.config")
local window = require("local.float-term.window")

local M = {
	_window = nil,
}

function M.setup(opts)
	config.setup(opts)

	local colors = config.opts.colors

	vim.api.nvim_set_hl(0, "FloatTermTabActive", { bg = colors.tab_active, fg = colors.text_active, bold = true })
	vim.api.nvim_set_hl(0, "FloatTermTabInactive", { bg = colors.tab_inactive, fg = colors.text_inactive })
	vim.api.nvim_set_hl(0, "FloatTermTabSeparatorActive", { bg = colors.tab_fill, fg = colors.tab_active })
	vim.api.nvim_set_hl(0, "FloatTermTabSeparatorInactive", { bg = colors.tab_fill, fg = colors.tab_inactive })
	vim.api.nvim_set_hl(0, "FloatTermTabFill", { bg = colors.tab_fill })
	vim.api.nvim_set_hl(0, "FloatTermNormal", { bg = colors.window, fg = colors.text_active })
	vim.api.nvim_set_hl(0, "FloatTermNormalNC", { bg = colors.window, fg = colors.text_active })
	vim.api.nvim_set_hl(0, "FloatTermFloat", { bg = colors.window, fg = colors.text_active })
	vim.api.nvim_set_hl(0, "FloatTermBorder", { bg = colors.window, fg = colors.border })
	vim.api.nvim_set_hl(0, "FloatTermBackdrop", { bg = "#000000", default = true })

	vim.api.nvim_create_user_command("FloatTermToggle", function() M.toggle() end, {})
	vim.api.nvim_create_user_command("FloatTermNew", function() M.new_terminal() end, {})
	vim.api.nvim_create_user_command("FloatTermNext", function() M.next() end, {})
	vim.api.nvim_create_user_command("FloatTermPrev", function() M.prev() end, {})

	_G.___float_term = {
		winbar_click = function(idx, _, button)
			if button ~= "l" then return end
			local win = vim.api.nvim_get_current_win()
			local win_term = M._window

			if win_term and win_term.win == win then
				win_term.active = idx
				win_term:open()
			end
		end,
	}
end

function M.toggle(opts)
	local win_term = M._window

	if not win_term then
		M._window = window.new(opts)
		M._window:open()
	else
		if not vim.api.nvim_win_is_valid(win_term.win) then
			win_term:open()
		else
			vim.api.nvim_win_close(win_term.win, true)
		end
	end
end

function M.new_terminal(opts)
	local win_term = M._window

	if not win_term then
		M._window = window.new(opts)
		M._window:open()
	else
		win_term:new_terminal(true, opts)
		win_term:open()
	end
end

function M.next()
	if not M._window then
		vim.notify("No floating terminal registered!", "warn", { title = "Float Term" })
		return
	end

	M._window:next()
end

function M.prev()
	if not M._window then
		vim.notify("No floating terminal registered!", "warn", { title = "Float Term" })
		return
	end

	M._window:prev()
end

return M
