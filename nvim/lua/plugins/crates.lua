return {
	"saecki/crates.nvim",

	tag = "stable",
	config = function()
		require("crates").setup({
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
		})
	end,
}
