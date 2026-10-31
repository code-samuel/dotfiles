-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- KEYBOARD CONFIGURATION && RELATED                     --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

---------------------
-- Variables
---------------------

local mainMod = "SUPER"
terminal = "kitty"
local menu = "rofi"
local filemanager = "nemo"

---------------------
-- Input
---------------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",
		kb_model = "intl",
		kb_options = "",
		kb_rules = "",
		repeat_rate = 20,
		repeat_delay = 350,
		follow_mouse = 1,
		accel_profile = "flat",
		sensitivity = 0,
	},
})

---------------------
-- Binds
---------------------

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. "+ D", hl.dsp.exec_cmd(filemanager))
hl.bind(mainMod .. "+ Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+ N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. "+ M", hl.dsp.exec_cmd("power-menu.sh &"))
hl.bind(mainMod .. "+ W", hl.dsp.exec_cmd("select-wallpaper.sh &"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd(
		[[bash -c 'GEOM=$(slurp) && sleep 0.2 && (pw-play /usr/share/sounds/freedesktop/stereo/camera-shutter.oga &) && grim -g "$GEOM" - | satty -f -']]
	)
)
-- safe screenshot bind
-- hl.bind(
-- mainMod .. " + SHIFT + S",
-- hl.dsp.exec_cmd([[bash -c 'GEOM=$(slurp) && sleep 0.2 && grim -g "$GEOM" - | satty -f -']])
-- )

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

---------------------
-- Workspaces
---------------------

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

---------------------
-- Windows
---------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
