return {
	{
		"folke/todo-comments.nvim",
		event = "User LazyFile",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
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
