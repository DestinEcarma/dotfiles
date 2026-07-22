return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "User LazyFile",

	config = function()
		require("bufferline").setup({
			-- highlights = require("catppuccin.special.bufferline").get_theme(),
			options = {
				mode = "tabs",
				buffer_close_icon = "",
				separator_style = "slant",
			},
		})
	end,
}
