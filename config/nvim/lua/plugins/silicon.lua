return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	opts = {
		disable_defaults = true,
	},

	init = function()
		local silicon = require("silicon")

		require("which-key").add({
			mode = { "v" },
			{ "<leader>s", group = "Silicon" },
			{
				"<leader>sc",
				function()
					require("nvim-silicon").clip()
				end,
				desc = "Copy code screenshot to clipboard",
			},
			{
				"<leader>ss",
				function()
					require("nvim-silicon").shoot()
				end,
				desc = "Create code screenshot",
			},
		})
	end,

	config = function()
		require("silicon").setup({
			font = "JetBrainsMono Nerd Font=24",
			theme = "Dracula",
		})
	end,
}
