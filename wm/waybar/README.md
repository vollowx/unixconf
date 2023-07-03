# Configs for Waybar

## Some differences between Sway and Hyprland

1. `sway/workspaces` / `wlr/workspaces`  
   In CSS, use class `focused` for Sway and class `active` for Hyprland to apply styles to current workspace button.  
   You probably also need to set
   ```json
   {
     "sort-by-number": true,
     "on-click": "activate",
     "on-scroll-up": "hyprctl dispatch workspace e+1",
     "on-scroll-down": "hyprctl dispatch workspace e-1"
   }
   ```
   inside.
2. `sway/mode` / `hyprland/submaps`
3. `sway/windows` / `hyprland/windows`
