return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
			refresh = { refresh_time = 50 },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "filename", "branch" },
			lualine_c = {
				{
					function()
						local rec_key = vim.fn.reg_recording()
						return rec_key == "" and "" or "● REC @" .. rec_key
					end,
					color = "DiagnosticError",
				},
			},
			lualine_x = { "diagnostics" },
			lualine_y = { "filetype" },
			lualine_z = {
				"location",
				"progress",
				function()
					return " " .. os.date("%H:%M")
				end,
			},
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
	},
}
