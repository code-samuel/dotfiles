hl.config({

	animations = {
		enabled = true,
	},
	general = {
		gaps_in = 5,
		gaps_out = 15,

		resize_on_border = true,
		border_size = 1,

		allow_tearing = false,
		layout = "dwindle",

		col = {
			inactive_border = "rgba(595959aa)",
		},
	},

	dwindle = { preserve_split = true },

	decoration = {
		active_opacity = 1,
		inactive_opacity = 0.85,
		fullscreen_opacity = 1,

		shadow = {
			enabled = true,
			range = 5,
			render_power = 2,
			color = 0xee15191c,
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

-- windows rules
hl.window_rule({
	name = "force-satty-floating",
	match = {
		class = "com.gabm.satty", -- ou apenas "satty" dependendo de como o app se registra
	},
	float = true,
	center = true, -- Opcional: força ele a abrir centralizado na tela
})
-- layer rules
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })

local rofiBlur = hl.layer_rule({
	name = "rofi-blur",
	match = { namespace = "rofi" },
	blur = true,
	animation = "slide",
})
