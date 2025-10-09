return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("todo-comments").setup({})
	end,
}
