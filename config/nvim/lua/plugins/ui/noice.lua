return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },

	---@module "noice"
	---@type NoiceConfig
	opts = {
		lsp = {
			progress = { enabled = false },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
			hover = { silent = true },
			signature = { auto_open = { enabled = false } },
		},
		-- you can enable a preset for easier configuration
		presets = {
			command_palette = true,
			long_message_to_split = true,
		},

		notify = { enabled = false },
	},
}
