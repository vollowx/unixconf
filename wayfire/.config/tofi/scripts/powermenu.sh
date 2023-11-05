#!/usr/bin/env bash

actions="Lock\nPoweroff\nReboot\nSuspend\nHibernate\nLogout"

selected=$(echo -e "$actions" | tofi --prompt-text ":power ")

if [ ! -z "$selected" ]; then
  case $selected in
  "Lock")
    swaylock -f
    ;;
  "Poweroff")
    systemctl poweroff
    ;;
  "Reboot")
    systemctl reboot
    ;;
  "Suspend")
    systemctl suspend
    ;;
  "Hibernate")
    systemctl hibernate
    ;;
  "Logout")
    swaymsg exit   # Sway
    wayland-logout # Wayfire
    ;;
  esac
fi
