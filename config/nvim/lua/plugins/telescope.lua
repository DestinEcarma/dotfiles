return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"andrew-george/telescope-themes",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	keys = {
		{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fp", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>ff", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Oldfiles" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
	},
	opts = {
		defaults = {
			file_ignore_patterns = { "node_modules" },
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")

		opts.extensions = {
			["ui-select"] = require("telescope.themes").get_dropdown({}),
		}

		telescope.setup(opts)
		telescope.load_extension("ui-select")
		telescope.load_extension("themes")
	end,
}
