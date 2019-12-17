export PATH="$HOME/.cargo/bin:$PATH"

# Makes some application (evince, gitg, etc.) use dark mode by default
# Works even if you start the application from rofi
export GTK_THEME=Adwaita:dark

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
