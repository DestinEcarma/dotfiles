return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "User LazyFile",

		config = function()
			require("bufferline").setup({
				options = {
					buffer_close_icon = "",
					separator_style = "slant",
				},
			})
		end,
	},
}
