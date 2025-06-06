vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"

vim.g.netrw_list_hide = [[node_modules/]]

vim.diagnostic.config({
	float = {
		scope = "line",
		border = "rounded",
	},
})

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "pwsh"
end
