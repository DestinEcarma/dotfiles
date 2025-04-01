local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),

	handlers = {
		["textDocument/hover"] = {
			border = "rounded",
		},

		["textDocument/signatureHelp"] = {
			border = "rounded",
		},
	},

	on_attach = function(client, _)
		local builtin = require("telescope.builtin")
		local wk = require("which-key")

		wk.add({
			mode = { "n" },
			{ "K", vim.lsp.buf.hover, desc = "Display documentation" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },

			{
				{ "<leader>l", group = "LSP" },
				{ "<leader>ld", vim.diagnostic.open_float, desc = "Display line diagnostics" },
				{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
				{ "<leader>lc", vim.lsp.buf.code_action, desc = "Code action" },
			},

			{ "<leader>fr", builtin.lsp_references, desc = "Telescope LSP references" },
			{ "<leader>fd", builtin.diagnostic, desc = "Telescope diagnostics" },
		})

		if client.server_capabilities.inlayHintProvider then
			local function toggle_inlay_hint()
				local value = vim.lsp.inlay_hint.is_enabled()

				vim.lsp.inlay_hint.enable(not value)
			end

			wk.add({ { "<leader>li", toggle_inlay_hint, desc = "Display inlay hints", mode = "n" } })
		end
	end,
}
