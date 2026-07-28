return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"folke/todo-comments.nvim",
		event = "User LazyFile",
		config = true,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "User LazyFile",
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
