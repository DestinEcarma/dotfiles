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
			{ "<C-P>", builtin.find_files, desc = "Find files" },
			{ "<C-F>", builtin.live_grep, desc = "Live grep" },

			{ "<leader>f", group = "Telescope" },
			{ "<leader>fp", builtin.find_files, desc = "Find files" },
			{ "<leader>ff", builtin.live_grep, desc = "Live grep" },
			{ "<leader>fb", builtin.buffers, desc = "Buffers" },
			{ "<leader>fo", builtin.oldfiles, desc = "Oldfiles" },
			{ "<leader>fh", builtin.help_tags, desc = "Help tags" },
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
