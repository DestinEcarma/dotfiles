return {
	"folke/snacks.nvim",
	dependencies = {
		-- "nvim-mini/mini.icons"
		"nvim-tree/nvim-web-devicons",
	},
	priority = 1000,
	lazy = false,

	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			preset = {
				header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
			},
			sections = {
				{ section = "terminal", cmd = "tty-clock -t -c", height = 11, padding = 1 },
				-- { section = "header" },
				{ section = "keys", padding = 2, gap = 1 },
				{
					section = "recent_files",
					icon = "",
					title = "Recet Files",
					indent = 2,
					padding = 1,
				},
				{ section = "startup" },
			},
		},
		explorer = { enabled = true },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = {
			enabled = true,
		},
		notifier = { enabled = true },
		picker = {
			sources = {
				explorer = {
					auto_close = true,
					layout = { layout = { position = "right" } },
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
