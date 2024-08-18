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
		})

		vim.keymap.set("n", "<C-b>", ":Neotree filesystem reveal left<CR>", {})
	end,
}
