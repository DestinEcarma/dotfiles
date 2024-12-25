return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_by_name = { "node_modules" },
					always_show = { ".gitignore" },
				},
			},
			window = {
				mappings = {
					["<c-b>"] = "close_window",
				},
			},
		})

		vim.keymap.set("n", "<C-B>", ":Neotree filesystem float<CR>", {
			silent = true,
		})
	end,
}
