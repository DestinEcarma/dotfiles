-- Lines
vim.opt.number = true
vim.opt.relativenumber = true

-- Window
vim.o.winborder = "rounded"

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Tree
vim.g.netrw_list_hide = [[node_modules/]]

-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	extends = "›",
	precedes = "‹",
}

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- When using windows, set the shell to PowerShell
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "pwsh"
end
