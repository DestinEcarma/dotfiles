return {
	{
		"kylechui/nvim-surround",
		event = "User LazyFile",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")

			npairs.setup({})

			local rule = require("nvim-autopairs.rule")
			local ts_conds = require("nvim-autopairs.ts-conds")

			npairs.add_rules({
				rule("then", "end", "lua"):with_pair(ts_conds.is_not_ts_node({ "string", "comment" })),
				rule("function.*%(.*%)$", "end", "lua")
					:with_pair(ts_conds.is_not_ts_node({ "string", "comment" }))
					:use_regex(true),
			})
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<C-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
			{ "<C-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
			{ "<C-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
			{ "<C-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
			{ "<C-\\>", "<CMD><C-U>TmuxNavigatePrevious<CR>" },
		},
	},
}
