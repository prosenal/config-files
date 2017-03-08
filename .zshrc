echo "grahics card:" $(cat /proc/acpi/bbswitch)

function emacs() {/usr/bin/emacs $@ -mm &}

typeset -U path
path=(~/bin $(ruby -e 'print Gem.user_dir')/bin $path[@])

export NVM_DIR="/home/alex/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# https://docs.coala.io/en/latest/Users/Shell_Autocompletion.html
autoload bashcompinit
bashcompinit

eval "$(register-python-argcomplete coala)"
