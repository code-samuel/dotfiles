local colors = dofile(os.getenv("HOME") .. "/.config/hypr/colors.lua")

local function with_alpha(hex, alpha)
	return hex:gsub("^0xff", "0x" .. alpha)
end

hl.config({

	animations = {
		enabled = true,
	},
	general = {
		gaps_in = 5,
		gaps_out = 10,

		resize_on_border = true,
		border_size = 1,

		allow_tearing = false,
		layout = "dwindle",

		col = {
			active_border = colors.primary,
			inactive_border = with_alpha(colors.outline_variant, "aa"),
		},
	},

	dwindle = { preserve_split = true },

	decoration = {
		active_opacity = 0.95,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1,

		shadow = {
			enabled = true,
			range = 5,
			render_power = 2,
			color = with_alpha(colors.shadow, "ee"),
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			new_optimizations = on,
			ignore_opacity = true,
			xray = true,
		},
	},
})
