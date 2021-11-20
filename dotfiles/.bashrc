# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

unset LS_COLORS
LS_COLORS='*=38;5;231:*.rs=38;5;166:*.go=38;5;27:*.md=38;5;27:.py*=38;5;228:*.html=1;49;31:*.otf=38;5;197:*.ttf=38;5;197:*.eot=38;5;197:*.woff2=38;5;197:*.woff=38;5;197:*.sass=38;5;205:*.scss=38;5;205:*.less=38;5;39:*.css=38;5;39:*.json=38;5;220:package.json=38;5;193:*.js=38;5;220:*.ts=38;5;45:*.tsx=38;5;26:*.jsx=38;5;26:*.vue=38;5;48:*.esd=38;5;60:*.dwm=38;5;60:*.swm=38;5;60:*.wim=38;5;60:*.cab=38;5;60:*.rz=38;5;60:*.7z=38;5;60:*.cpio=38;5;60:*.zoo=38;5;60:*.ace=38;5;60:*.alz=38;5;60:*.rar=38;5;60:*.sar=38;5;60:*.ear=38;5;60:*.war=38;5;60:*.jar=38;5;60:*.rpm=38;5;60:*.deb=38;5;60:*.tz=38;5;60:*.tbz2=38;5;60:*.tbz=38;5;60:*.bz=38;5;60:*.bz2=38;5;60:*.tzst=38;5;60:*.zst=38;5;60:*.xz=38;5;60:*.lzo=38;5;60:*.lz=38;5;60:*.lrz=38;5;60:*.gz=38;5;60:*.dz=38;5;60:*.z=38;5;60:*.zip=38;5;60:*.t7z=38;5;60:*.tzo=38;5;60:*.txz=38;5;60:*.tlz=38;5;60:*.lzma=38;5;60:*.lzh=38;5;60:*.lz4=38;5;60:*.lha=38;5;60:*.taz=38;5;60:*.arj=38;5;60:*.arc=38;5;60:*.tgz=38;5;60:*.tar=38;5;60:*.zwc=38;5;183:*.sh=38;5;183:.bash*=38;5;183:.bash_profile=38;5;183:*.bash=38;5;183:.zshenv=38;5;183:.zprofile=38;5;183:.zsh*=38;5;183:.zcomp*=38;5;183:.*config=38;5;183:*.fish=38;5;183:*.zsh=38;5;183:.*rc=38;5;183:ex=38;5;217:ln=38;5;122:di=38;5;117:'
export LS_COLORS

# Starship config
export STARSHIP_CONFIG=$ROOT/starship/starship.toml

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

hash -d c="$C"
hash -d win-home="$C/Users/kevin"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# declare -A CUSTOM_COMMANDS=(
#    [::update]="sudo bash -c \"apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y clean\""
#    [::root]="cd \$ROOT"
#    [::zsh]="cd ~/.oh-my-zsh"
#    [::win-home]="cd \$C/Users/kevin"
#    [::c]="cd \$C"
#    [::explore]="explorer.exe"
#    [::notepad]="Notepad.exe"
#    [::dundalk]="cd ~win-home/'OneDrive - Dundalk Institute of Technology'"
#    [::vite-init]="pnpm create vite"
#    [::cra]="pnpm dlx create-react-app"
#    [::comp]="source ~/.zshrc"
#    [::y2]="cd ~/year-2"
#    [::edit-root]="code \$ROOT"
#    [::img]="termimage"
#    [::disk]="ncdu"
#    [::train]="sl"
#    [::git]="git_helper"
#    [::mern]="create_mern_app"
#    [::print]="printer"
#    [::ip]="curl https://ipecho.net/plain; echo"
#    [::port]="lsof -i "
# )

# if [[ ${#CUSTOM_COMMANDS[@]} -gt 0 ]]
#  then
#    # declare -A list
#    # list=( $CUSTOM_COMMANDS )
#    for key in {!CUSTOM_COMMANDS[@]} 
#    do
#       echo "$key"="${CUSTOM_COMMANDS[$key]}"
#    #   alias "${key}"="${CUSTOM_COMMANDS[$key]}"
#    done
#    unset list key val
# fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
eval "$(starship init bash)"
eval "$(zoxide init bash)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
