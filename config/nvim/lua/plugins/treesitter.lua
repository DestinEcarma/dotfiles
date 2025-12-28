return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "lua", "vim", "vimdoc" },
		highlight = { enable = true },
		indent = { enable = true },
	},
}
