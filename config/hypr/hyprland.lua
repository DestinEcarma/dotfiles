local HOME = os.getenv("HOME")

local function is_file_exists(name)
	local file = io.open(name, "r")
	if file ~= nil then
		io.close(file)
		return true
	else
		return false
	end
end

require("hyprland.env")
require("hyprland.execs")
require("hyprland.general")
require("hyprland.rules")
require("hyprland.keybinds")

if is_file_exists(HOME .. "/.config/hypr/custom") then
	require("custom")
end
