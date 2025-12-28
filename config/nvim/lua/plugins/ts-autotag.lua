return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		opts = {
			enable_rename = true,
			enable_close = true,
			enable_close_on_slash = true,
		},
	},
}
