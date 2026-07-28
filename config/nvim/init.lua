-- Core Config
require("config")
require("config.autocmd")
require("config.theme")

-- Local Plugins
require("local.sessions").setup()
require("local.float-term").setup()

-- Lazy.nvim Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
	{ import = "plugins" },
	{ import = "plugins.ui" },
	{ import = "plugins.themes" },
	{ import = "plugins.langs" },
})
