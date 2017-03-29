echo "grahics card:" $(cat /proc/acpi/bbswitch)

function emacs() {/usr/bin/emacs $@ -mm &}

function evince() {/usr/bin/evince $@ &}

typeset -U path
path=(~/bin $(ruby -e 'print Gem.user_dir')/bin $path[@])

export NVM_DIR="/home/alex/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PYENV_ROOT="$HOME/Code/pyenv"
path=($PYENV_ROOT/bin $path[@])
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"
