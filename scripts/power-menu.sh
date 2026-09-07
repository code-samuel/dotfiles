#!/bin/bash

chosen=$(printf "Lock\0icon\x1fsystem-lock-screen\nLogout\0icon\x1fsystem-log-out\nSuspend\0icon\x1fmedia-playback-pause\nReboot\0icon\x1fsystem-reboot\nShutdown\0icon\x1fsystem-shutdown" |
  rofi -dmenu -show-icons -p "Power" -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
*Lock) hyprlock ;;
*Logout) hyprctl dispatch exit ;;
*Suspend) systemctl suspend ;;
*Reboot) systemctl reboot ;;
*Shutdown) systemctl poweroff ;;
esac
