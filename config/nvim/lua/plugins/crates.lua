return {
	"saecki/crates.nvim",
	tag = "stable",
	opts = {
		completion = {
			cmp = {
				enabled = true,
			},
		},
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
			hover = true,
		},
	},
}
