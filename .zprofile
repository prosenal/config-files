# Follow XDG Base Directory specification
# See: https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Make certain application (evince, gitg, etc.) use dark mode by default.
# Works even if you start the application from rofi
export GTK_THEME=Adwaita:dark

# Start nvm, as per package instructions
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

# Start pyenv, as per:
# https://github.com/pyenv/pyenv#basic-github-checkout
export PYENV_ROOT="$HOME/Code/pyenv"
path=($PYENV_ROOT/bin $path[@])
eval "$(pyenv init -)"

# Start pyenv-vitrualenv, as per:
# https://github.com/pyenv/pyenv-virtualenv#installing-as-a-pyenv-plugin
eval "$(pyenv virtualenv-init -)"

# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
