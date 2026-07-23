return {
	"AlexvZyl/nordic.nvim",
	lazy = true,
	priority = 1000,
	---@module "nordic"
	---@type NordicOptions
	opts = {
		on_highlight = function(highlights, palette)
			highlights.WinBar = { bg = palette.bg, fg = palette.fg }
			highlights.WinBarNC = { bg = palette.bg, fg = palette.gray5 }

			highlights.NavicText = { bg = palette.bg, fg = palette.white0_normal }
			highlights.NavicSeparator = { bg = palette.bg, fg = palette.gray5 }

			highlights.NavicIconsFile = { bg = palette.bg, fg = palette.white1 }
			highlights.NavicIconsModule = { bg = palette.bg, fg = palette.blue1 }
			highlights.NavicIconsNamespace = { bg = palette.bg, fg = palette.blue2 }
			highlights.NavicIconsPackage = { bg = palette.bg, fg = palette.blue0 }

			highlights.NavicIconsClass = { bg = palette.bg, fg = palette.yellow.base }
			highlights.NavicIconsMethod = { bg = palette.bg, fg = palette.blue1 }
			highlights.NavicIconsProperty = { bg = palette.bg, fg = palette.cyan.base }
			highlights.NavicIconsField = { bg = palette.bg, fg = palette.cyan.dim }
			highlights.NavicIconsConstructor = { bg = palette.bg, fg = palette.orange.base }

			highlights.NavicIconsEnum = { bg = palette.bg, fg = palette.magenta.base }
			highlights.NavicIconsInterface = { bg = palette.bg, fg = palette.yellow.bright }
			highlights.NavicIconsFunction = { bg = palette.bg, fg = palette.blue2 }
			highlights.NavicIconsVariable = { bg = palette.bg, fg = palette.white0_reduce_blue }
			highlights.NavicIconsConstant = { bg = palette.bg, fg = palette.orange.bright }

			highlights.NavicIconsString = { bg = palette.bg, fg = palette.green.base }
			highlights.NavicIconsNumber = { bg = palette.bg, fg = palette.orange.base }
			highlights.NavicIconsBoolean = { bg = palette.bg, fg = palette.orange.dim }
			highlights.NavicIconsArray = { bg = palette.bg, fg = palette.green.dim }
			highlights.NavicIconsObject = { bg = palette.bg, fg = palette.red.bright }
			highlights.NavicIconsKey = { bg = palette.bg, fg = palette.red.base }
			highlights.NavicIconsStruct = { bg = palette.bg, fg = palette.yellow.dim }
			highlights.NavicIconsEvent = { bg = palette.bg, fg = palette.red.dim }
			highlights.NavicIconsOperator = { bg = palette.bg, fg = palette.cyan.bright }
			highlights.NavicIconsEnumMember = { bg = palette.bg, fg = palette.magenta.bright }
			highlights.NavicIconsTypeParameter = { bg = palette.bg, fg = palette.green.bright }
		end,
	},
}
