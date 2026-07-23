-- Leader
vim.g.mapleader = " "

-- Diagnostics
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.HINT] = "󰌶",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

-- LSP
vim.lsp.enable({
	"lua_ls",
	"vtsls",
})

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.showmode = false

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Tabs & Indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- File Explorer
vim.g.netrw_list_hide = [[node_modules/]]

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Shell
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "pwsh"
end

-- Backup
local undodir = vim.fn.expand("~/.cache/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir)
end

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.autoread = true
vim.opt.confirm = true
