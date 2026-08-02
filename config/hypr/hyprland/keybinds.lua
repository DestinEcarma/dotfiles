-------------------
---- Utilities ----
-------------------

local function toggle_game_mode()
	local game_mode = (hl.get_config("animations.enabled") == false)

	if game_mode then
		hl.exec_cmd("hyprctl reload")
		return
	end

	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0,
			border_size = 0,
		},
		animations = { enabled = false },
		decoration = {
			rounding = 0,
			active_opacity = 1,
			inactive_opacity = 1,
			dim_inactive = false,
			shadow = { enabled = false },
			blur = { enabled = false },
		},
	})
end

hl.bind("SUPER + F1", toggle_game_mode)

hl.bind("SUPER + S", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("hyprshutdown"))

----------------------
---- Applications ----
----------------------

hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("kitty --class float -e dooit"))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("kitty --class float -e clipse"))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("kitty --class float -e paper-tui"))

-- stylua: ignore start
hl.bind("SUPER + Space", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/themes/drun.rasi"))
hl.bind( "SUPER + C", hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort -theme ~/.config/rofi/themes/calc.rasi"))
-- stylua: ignore end

hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"))

-----------------------------
---- Window Manipulation ----
-----------------------------

local function window_toggle_special()
	local w = hl.get_active_window()
	if not w then
		return
	end

	local ws = w.workspace and w.workspace.name or ""
	if ws:match("^special") then
		hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), follow = true }))
	else
		hl.dispatch(hl.dsp.window.move({ workspace = "special", follow = true }))
	end
end

local function window_cycle_next()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end

local function ___window_make_sure_floating()
	local w = hl.get_active_window()
	if not w then
		return
	end

	if not w.floating then
		hl.dispatch(hl.dsp.window.float())
	end
end

local function window_bring_top()
	___window_make_sure_floating()
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end

local function window_bring_bottom()
	___window_make_sure_floating()
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "bottom" }))
end

hl.bind("SUPER + Q", hl.dsp.window.close())

hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + F", window_bring_top)
hl.bind("SUPER + B", window_bring_bottom)
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen())

hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

hl.bind("SUPER + Right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + Left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + Up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
hl.bind("SUPER + Down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, drag = true })
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true, drag = true })

hl.bind("ALT + TAB", window_cycle_next)
-- TODO: figure out for cycling previous, `{ next = false }` does not work

hl.bind("SUPER + SHIFT + X", window_toggle_special)

--------------------------------
---- Workspace Manipulation ----
--------------------------------

local function cycle_layout()
	local layouts = { "scrolling", "dwindle", "master", "monocle" }
	local workspace = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

	local next_layout = "dwindle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end

hl.bind("SUPER + SHIFT + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.focus({ workspace = "-1" }))

hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

for i = 1, 10 do
	local key = i % 10

	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + X", hl.dsp.workspace.toggle_special())

hl.bind("SUPER + M", cycle_layout)

---------------
---- Media ----
---------------

-- stylua: ignore start
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { repeat_key = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { repeat_key = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { repeat_key = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { repeat_key = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { repeat_key = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { repeat_key = true, locked = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"), { repeat_key = true, locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { repeat_key = true, locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { repeat_key = true, locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), { repeat_key = true, locked = true })
-- stylua: ignore end
