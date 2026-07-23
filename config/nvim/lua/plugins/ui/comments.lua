return {
	{
		"folke/todo-comments.nvim",
		event = "User LazyFile",
		dependencies = { "nvim-lua/plenary.nvim" },
        -- stylua: ignore
		keys = {
			{ "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo", },
            { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "HACK" } }) end, desc = "Todo/Fix/Fixme/Hack", },
		},
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
