return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename", "branch" },
				lualine_c = {
					function()
						local rec_key = vim.fn.reg_recording()

						if rec_key ~= "" then
							return " " .. rec_key
						end

						return ""
					end,
				},
				lualine_x = { "diagnostics" },
				lualine_y = { "filetype" },
				lualine_z = { "location", "progress" },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
