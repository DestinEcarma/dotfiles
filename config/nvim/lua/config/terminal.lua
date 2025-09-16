local create_floating_window = require("utils.floating-window")

local terminal = {
	buf = -1,
	win = -1,
}

local function toggle_floating_terminal()
	if not vim.api.nvim_win_is_valid(terminal.win) then
		terminal = create_floating_window({ buf = terminal.buf })

		if vim.bo[terminal.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end

		vim.api.nvim_set_current_buf(terminal.buf)
		vim.cmd("startinsert")
	else
		vim.api.nvim_win_hide(terminal.win)
	end
end

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(terminal.win) then
		vim.cmd("botright split")
		vim.cmd("resize 10")

		terminal.win = vim.api.nvim_get_current_win()

		if terminal.buf and vim.api.nvim_buf_is_valid(terminal.buf) then
			vim.api.nvim_win_set_buf(terminal.win, terminal.buf)
		else
			vim.cmd("terminal")

			terminal.buf = vim.api.nvim_get_current_buf()
			vim.bo[terminal.buf].buflisted = false
			vim.bo[terminal.buf].bufhidden = "hide"
		end

		vim.api.nvim_set_current_buf(terminal.buf)
		vim.cmd("startinsert")
	else
		vim.api.nvim_win_hide(terminal.win)
	end
end

vim.api.nvim_create_user_command("FloatingTerminal", toggle_floating_terminal, { desc = "Toggle floating terminal" })
vim.api.nvim_create_user_command("Terminal", toggle_terminal, { desc = "Toggle terminal" })

vim.keymap.set({ "n", "t" }, "<C-`>", toggle_floating_terminal, { desc = "Toggle floating terminal" })
vim.keymap.set({ "n", "t" }, "<A-`>", toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set({ "t" }, "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
