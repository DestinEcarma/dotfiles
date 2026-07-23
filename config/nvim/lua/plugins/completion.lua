return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
	version = "1.*",
	event = "InsertEnter",

	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		snippets = { preset = "default" },

		keymap = {
			preset = "enter",
			["<Tab>"] = { "accept", "fallback" },
			["<C-b>"] = { "scroll_signature_up", "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_signature_down", "scroll_documentation_down", "fallback" },
		},

		appearance = { nerd_font_variant = "mono" },

		completion = {
			list = { selection = { preselect = false, auto_insert = false } },

			menu = {
				max_height = 25,
				draw = {
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon" },
						{ "label" },
						{ "kind" },
					},
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},

			ghost_text = { enabled = true },
		},

		-- signature = { enabled = true },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = { enabled = false },
	},
	opts_extend = { "sources.default" },
}
