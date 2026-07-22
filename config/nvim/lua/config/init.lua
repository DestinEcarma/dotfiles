-- Inline hints
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

vim.lsp.enable({
	"lua_ls",
	"vtsls",
})

-- Lines
vim.opt.number = true
vim.opt.relativenumber = true

-- Window
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false

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

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- When using windows, set the shell to PowerShell
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "pwsh"
end

vim.opt.termguicolors = true
