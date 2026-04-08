# My Archlinux Dotfiles

## Specs

- Shell: **zsh**
- Login Manager: **greetd** (tuigreet)
- Window Manager: **hyprland**

- Terminal: **kitty**
- Bar: **quickshell**
- Notification Daemon: **quickshell**
- App Launcher: **rofi**
- Screen Lock: **hyprlock**
- Idle Daemon: **hypridle**
- Screenshot Utility: **hyprshot**
- Color Picker Utility: **hyprpicker**
- Wallpaper Utility: **hyprpaper**
- Wallpaper Manager: **quickshell**

## Installation

```bash
cd ~ # make sure you're in the home directory
git clone git@github.com:dracotato/arch-dots.git .dots
cd .dots
# with stow
stow -v . -t=~
# without stow...
# use cp to copy each directory
```
