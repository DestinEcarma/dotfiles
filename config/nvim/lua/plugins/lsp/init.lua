return {
	{
		"williamboman/mason.nvim",
		tag = "stable",
		lazy = false,
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "User LazyFile", "VeryLazy" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = { "lua", "vim", "vimdoc" },
			highlight = { enable = true },
			indent = { enable = true },
			folds = { enable = true },
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			virtual_symbol_position = "inline",
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_named_colors = true,
		},
	},
}
