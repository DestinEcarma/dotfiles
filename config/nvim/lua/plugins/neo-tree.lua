return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	init = function()
		require("which-key").add({
			{ "<C-B>", "<cmd>Neotree filesystem float<CR>", desc = "Toggle file tree", mode = { "n" } },
		})
	end,

	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			filesystem = {
				filtered_items = {
					hide_by_name = { "node_modules" },
					always_show = { ".gitignore" },
				},
			},
			window = {
				position = "float",
				mappings = {
					["<c-b>"] = "close_window",
				},
			},
		})
	end,
}
