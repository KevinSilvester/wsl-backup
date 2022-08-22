export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$(/usr/bin/printenv PATH | /usr/bin/perl -ne 'print join(":", grep { !/\/mnt\/[a-z]/ } split(/:/));')
export PATH="/mnt/c/Users/kevin/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
export PATH="/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application:$PATH"
export PATH="/mnt/c/Program Files/JetBrains/IntelliJ IDEA 2021.2.2/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
# export PATH="/mnt/c/WINDOWS/system32:$PATH"
# export PATH="/mnt/c/WINDOWS:$PATH"

. "$HOME/.cargo/env"

export ZSH="$HOME/.oh-my-zsh"
export ROOT="$HOME/.config"
export C="/mnt/c"

export FZF_DEFAULT_OPS="--extended"
export NVM_DIR="$HOME/.nvm"
export BROWSER=brave.exe
