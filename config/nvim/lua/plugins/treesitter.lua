return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "User LazyFile",
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	opts_extend = { "ensure_installed" },
	opts = {
		ensure_installed = { "lua", "vim", "vimdoc" },
		highlight = { enable = true },
		indent = { enable = true },
		folds = { enable = true },
	},
}
