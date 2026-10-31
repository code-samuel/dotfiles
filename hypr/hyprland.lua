require("monitors")
require("binds")
require("autostart")

hl.env("SSH_AUTH_SOCK", "/run/user/1000/ssh-agent.socket")
hl.env("SSH_ASKPASS_REQUIRE", "prefer")
hl.env("SSH_ASKPASS", "ksshaskpass")
