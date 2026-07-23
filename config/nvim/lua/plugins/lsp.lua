return {
	{
		"williamboman/mason.nvim",
		tag = "stable",
		lazy = false,
		config = true,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		---@module "lazydev"
		---@type lazydev.Config
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
}
