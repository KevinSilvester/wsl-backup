[[ -s ~/.bashrc ]] && source ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH" 
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin" 
export PATH="$HOME/.pyenv/bin:$PATH" 
export PATH="$HOME/.local/bin:$PATH"
. "$HOME/.cargo/env"
export ZSH="$HOME/.oh-my-zsh" 
export ROOT="$HOME/__root__" 
export C="/mnt/c" 
export FZF_DEFAULT_OPS="--extended" 
export NVM_DIR="$HOME/.nvm"