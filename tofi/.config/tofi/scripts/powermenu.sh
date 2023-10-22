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
    loginctl terminate-session $XDG_SESSION_ID
    ;;
  esac
fi
