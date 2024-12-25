return {
	"goolord/alpha-nvim",

	config = function()
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("<C-B>", " > File Tree", "<cmd>Neotree float<CR>"),
			dashboard.button("<C-F>", "󰍉 > Live Grep", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("<C-P>", " > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("<leader>fo", " > Recently Opened Files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("<leader>fh", " > Help Tags", "<cmd>Telescope help_tags<CR>"),
			dashboard.button("<C-Q>", "󰿅 > Quit", "<cmd>q<CR>"),
		}

		require("alpha").setup(dashboard.opts)
	end,
}
