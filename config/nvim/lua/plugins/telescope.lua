return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope-ui-select.nvim",
	},

	init = function()
		local builtin = require("telescope.builtin")

		require("which-key").add({
			mode = { "n" },
			{ "<C-P", builtin.find_files, desc = "Telescope find files" },
			{ "<C-F>", builtin.live_grep, desc = "Telescope live grep" },

			{
				mode = { "n" },
				{ "<leader>f", group = "Telescope" },
				{ "<leader>fb", builtin.buffers, desc = "Telescope buffers" },
				{ "<leader>fo", builtin.oldfiles, desc = "Telescope oldfiles" },
				{ "<leader>fh", builtin.help_tags, desc = "Telescope help tags" },
			},
		})
	end,

	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		telescope.load_extension("ui-select")
	end,
}
