local create_floating_window = require("utils.floating-window")

local terminal = {
	buf = -1,
	win = -1,
}

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(terminal.win) then
		terminal = create_floating_window({ buf = terminal.buf })

		if vim.bo[terminal.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(terminal.win)
	end
end

vim.api.nvim_create_user_command("FloatingTerminal", toggle_terminal, { desc = "Toggle floating terminal" })
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Toggle floating terminal" })
