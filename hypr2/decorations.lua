hl.config({

	general = {
		gaps_in = 6,
		gaps_out = 12,

		resize_on_border = true,
		border_size = 2,

		allow_tearing = false,
		layout = "master",
	},

	decoration = {
		rouding = 8,
		rounding_power = 2,
		active_opacity = 1,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1,

		shadow = {
			enabled = true,
			range = 32,
			render_power = 2,
		},

		blur = {

			enabled = true,
			size = 5,
			passes = 4,
			new_optimizations = on,
			ignore_opacity = true,
			xray = true,
		},
	},
})

-- layer rules
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })

local rofiBlur = hl.layer_rule({
	name = "rofi-blur",
	match = { namespace = "rofi" },
	blur = true,
	animation = "slide",
})
