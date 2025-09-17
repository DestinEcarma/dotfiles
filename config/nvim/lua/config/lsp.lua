vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,

	float = {
		border = "rounded",
		source = true,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		local builtin = require("telescope.builtin")
		local wk = require("which-key")

		wk.add({
			mode = { "n" },
			{ "K", vim.lsp.buf.hover, desc = "Display Documentation" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "<leader>e", vim.diagnostic.open_float, desc = "Display Line Diagnostics" },
			{ "<leader>ra", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },

			{ "<leader>l", group = "LSP" },
			{ "<leader>ll", require("lsp_lines").toggle, desc = "Toggle LSP Lines" },
			{ "<leader>lK", vim.lsp.buf.hover, desc = "Display Documentation" },
			{ "<leader>lgd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "<leader>le", vim.diagnostic.open_float, desc = "Display Line Diagnostics" },
			{ "<leader>lra", vim.lsp.buf.rename, desc = "Rename" },
			{ "<leader>lca", vim.lsp.buf.code_action, desc = "Code Action" },

			{ "<leader>fr", builtin.lsp_references, desc = "Telescope LSP References" },
			{ "<leader>fd", builtin.diagnostics, desc = "Telescope LSP Diagnostics" },
			{ "<leader>fq", builtin.quickfix, desc = "Telescope LSP Quickfix" },
		})

		if client:supports_method("textDocument/inlayHint") then
			local function inlay_hint()
				local value = vim.lsp.inlay_hint.is_enabled()

				vim.lsp.inlay_hint.enable(not value)
			end

			wk.add({ { "<leader>li", inlay_hint, desc = "Display inlay hints", mode = "n" } })
		end
	end,
})
