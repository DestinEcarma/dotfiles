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
			{
				"<C-b>",
				"<cmd>Neotree filesystem reveal right focus<CR>",
				desc = "Open Neo Tree",
				mode = { "n" },
			},
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
				mappings = {
					["<C-b>"] = "close_window",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
	end,
}
