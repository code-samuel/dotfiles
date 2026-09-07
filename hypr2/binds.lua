local mainMod = "SUPER"

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
		accel_profile = flat,
		sensitivity = 0,
	},
})

hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd("pkill rofi || rofi"), { release = true })
hl.bind(mainMod .. "+ D", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. "+ Q", hl.dsp.exec_cmd("kill"))
hl.bind(mainMod .. "+ Q", hl.dsp.exec_cmd("killactive"))
