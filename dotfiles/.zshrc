## Powerlevel10k Prompt
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# ---------------------------------------------------------------------------------------------

# Custom ls and exa colors
# typeset -a ls_c
# ls_c=(
#    'di=1;38;5;117'
#    'ln=1;38;5;122'
#    'ex=38;5;217'
#    '*.md=38;5;106'
#    'README.md=1;38;5;136'
#    '.*rc=38;5;183'
#    '*.zsh=38;5;183'
#    '*.fish=38;5;183'
#    '.*config=38;5;183'
#    '.zcomp*=38;5;183'
#    '.zsh*=38;5;183'
#    '.zprofile=38;5;183'
#    '.zshenv=38;5;183'
#    '*.bash=38;5;183'
#    '.bash_profile=38;5;183'
#    '.bash*=38;5;183'
#    '*.sh=38;5;183'
#    '*.zwc=38;5;183'
#    '*.tar=38;5;60'
#    '*.tgz=38;5;60'
#    '*.arc=38;5;60'
#    '*.arj=38;5;60'
#    '*.taz=38;5;60'
#    '*.lha=38;5;60'
#    '*.lz4=38;5;60'
#    '*.lzh=38;5;60'
#    '*.lzma=38;5;60'
#    '*.tlz=38;5;60'
#    '*.txz=38;5;60'
#    '*.tzo=38;5;60'
#    '*.t7z=38;5;60'
#    '*.zip=38;5;60'
#    '*.z=38;5;60'
#    '*.dz=38;5;60'
#    '*.gz=38;5;60'
#    '*.lrz=38;5;60'
#    '*.lz=38;5;60'
#    '*.lzo=38;5;60'
#    '*.xz=38;5;60'
#    '*.zst=38;5;60'
#    '*.tzst=38;5;60'
#    '*.bz2=38;5;60'
#    '*.bz=38;5;60'
#    '*.tbz=38;5;60'
#    '*.tbz2=38;5;60'
#    '*.tz=38;5;60'
#    '*.deb=38;5;60'
#    '*.rpm=38;5;60'
#    '*.jar=38;5;60'
#    '*.war=38;5;60'
#    '*.ear=38;5;60'
#    '*.sar=38;5;60'
#    '*.rar=38;5;60'
#    '*.alz=38;5;60'
#    '*.ace=38;5;60'
#    '*.zoo=38;5;60'
#    '*.cpio=38;5;60'
#    '*.7z=38;5;60'
#    '*.rz=38;5;60'
#    '*.cab=38;5;60'
#    '*.wim=38;5;60'
#    '*.swm=38;5;60'
#    '*.dwm=38;5;60'
#    '*.esd=38;5;60'
#    '*.vue=38;5;48'
#    '*.jsx=38;5;26'
#    '*.tsx=38;5;26'
#    '*.ts=38;5;45'
#    '*.js=38;5;220'
#    'package.json=38;5;193'
#    '*.json=38;5;220'
#    '*.css=38;5;39'
#    '*.less=38;5;39'
#    '*.scss=38;5;205'
#    '*.sass=38;5;205'
#    '*.woff=38;5;197'
#    '*.woff2=38;5;197'
#    '*.eot=38;5;197'
#    '*.ttf=38;5;197'
#    '*.otf=38;5;197'
#    '*.html=1;49;31'
#    # '*.yml=38;5;204'
#    # '.git*=38;5;203'
#    '.py*=38;5;228'
#    '*.md=38;5;27'
#    '*.go=38;5;27'
#    '*.rs=38;5;166'
#    '*=38;5;231'
# )

# unset previous LS_COLORS 
unset LS_COLORS

# ls_col() {
#    for col in $ls_c; do
#       export LS_COLORS="$col:$LS_COLORS"
#    done
#    echo $LS_COLORS
#    echo -ne 'Loading Colours ...'
#    unset ls_c
# }

export LS_COLORS="*=38;5;231:*.rs=38;5;166:*.go=38;5;27:*.md=38;5;27:.py*=38;5;228:*.html=1;49;31:*.otf=38;5;197:*.ttf=38;5;197:*.eot=38;5;197:*.woff2=38;5;197:*.woff=38;5;197:*.sass=38;5;205:*.scss=38;5;205:*.less=38;5;39:*.css=38;5;39:*.json=38;5;220:package.json=38;5;193:*.js=38;5;220:*.ts=38;5;45:*.tsx=38;5;26:*.jsx=38;5;26:*.vue=38;5;48:*.esd=38;5;60:*.dwm=38;5;60:*.swm=38;5;60:*.wim=38;5;60:*.cab=38;5;60:*.rz=38;5;60:*.7z=38;5;60:*.cpio=38;5;60:*.zoo=38;5;60:*.ace=38;5;60:*.alz=38;5;60:*.rar=38;5;60:*.sar=38;5;60:*.ear=38;5;60:*.war=38;5;60:*.jar=38;5;60:*.rpm=38;5;60:*.deb=38;5;60:*.tz=38;5;60:*.tbz2=38;5;60:*.tbz=38;5;60:*.bz=38;5;60:*.bz2=38;5;60:*.tzst=38;5;60:*.zst=38;5;60:*.xz=38;5;60:*.lzo=38;5;60:*.lz=38;5;60:*.lrz=38;5;60:*.gz=38;5;60:*.dz=38;5;60:*.z=38;5;60:*.zip=38;5;60:*.t7z=38;5;60:*.tzo=38;5;60:*.txz=38;5;60:*.tlz=38;5;60:*.lzma=38;5;60:*.lzh=38;5;60:*.lz4=38;5;60:*.lha=38;5;60:*.taz=38;5;60:*.arj=38;5;60:*.arc=38;5;60:*.tgz=38;5;60:*.tar=38;5;60:*.zwc=38;5;183:*.sh=38;5;183:.bash*=38;5;183:.bash_profile=38;5;183:*.bash=38;5;183:.zshenv=38;5;183:.zprofile=38;5;183:.zsh*=38;5;183:.zcomp*=38;5;183:.*config=38;5;183:*.fish=38;5;183:*.zsh=38;5;183:.*rc=38;5;183:README.md=1;38;5;136:*.md=38;5;106:ex=38;5;217:ln=1;38;5;122:di=1;38;5;117:$LS_COLORS"

# new colors for exa
export EXA_COLORS="ga=38;5;48:gm=38;5;221:gv=38;5;223:gd=38;5;160:gt=38;5;140:da=38;5;145:$EXA_COLORS"

# ---------------------------------------------------------------------------------------------

# Starship config
export STARSHIP_CONFIG=$ROOT/starship/starship.toml

# Specify location of HISTFILE as the env variable is unset when switching between bash and zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=500
export SAVEHIST=2000

# ---------------------------------------------------------------------------------------------

# functions on initial load

# ls_col

# ---------------------------------------------------------------------------------------------

# oh-my-zsh custom theme
# ZSH_THEME="smushed"

# ---------------------------------------------------------------------------------------------

# Plugins I made and some that I got from Oh-My-Zhs plugin page https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
   # dotenv
   extract
   custom-search
   k
   printer
   git-helper
   colorize
)

autoload -U colors && colors

# ---------------------------------------------------------------------------------------------

hash -d c="$C"
hash -d win-home="$C/Users/kevin"

# ---------------------------------------------------------------------------------------------

CUSTOM_COMMANDS=(
   ::update     "sudo bash -c \"apt-get update && apt-get upgrade && apt-get autoremove && apt-get clean\""
   ::root       "z \$ROOT"
   ::zsh        "z ~/.oh-my-zsh"
   ::win-home   "z \$C/Users/kevin"
   ::c          "z \$C"
   ::explore    "explorer.exe"
   ::notepad    "Notepad.exe"
   ::dkit       "z ~win-home/'OneDrive - Dundalk Institute of Technology'"
   ::vite-init  "pnpm create vite"
   ::cra        "pnpm dlx create-react-app"
   ::comp       "source ~/.zshrc"
   ::y2         "z ~/year-2"
   ::edit-root  "code \$ROOT"
   ::z-update   "omz update"
   ::img        "termimage"
   ::train      "sl"
   ::git        "_git_helper"
   ::mern       "create_mern_app"
   ::print      "_printer"
   ::ip         "curl https://ipecho.net/plain; echo"
   ::port       "lsof -i "
   ::colours    "colours"
   cd           "__zoxide_z"
   calc         "eva"
   ll           "exa -F --icons --no-user --group-directories-first --color=always --color-scale"
   lg           "exa -aF --icons --no-user --group-directories-first --color=always --color-scale --no-permissions"
   la           "exa -laF --git --icons --no-user --group-directories-first --color=always --color-scale"
   tla          "exa -aFT --icons --git --no-user --group-directories-first -I=\"node_modules|.git|.next|.svelte-kit|.idea\" --color=always --color-scale --no-permissions"
   nla          "exa -laFT --icons --git --no-user --group-directories-first --level=2 -I=\"node_modules|.git|.next|.svelte-kit|.idea\" --color=always --color-scale"
   nla2         "exa -laFT --icons --git --no-user --group-directories-first --level=3 -I=\"node_modules|.git|.next|.svelte-kit|.idea\" --color=always --color-scale"
   brave	      "brave.exe"
   bcat		   "bat --paging=never"
)

if [[ ${#CUSTOM_COMMANDS} -gt 0 ]]; then
   typeset -A list
   list=( $CUSTOM_COMMANDS )
   for key val in ${(@kv)list}; do
     alias "${key}"="${val}"
   done
   unset list key val
fi

# source: - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
ZSH_WEB_SEARCH_ENGINES=(
   @google        "https://www.google.com/search?q="
   @duckduckgo    "https://www.duckduckgo.com/?q="
   @github        "https://github.com/search?q="
   @youtube       "https://www.youtube.com/results?search_query="
   @yugen         "https://yugen.to/search/?q="
   @9anime        "https://9anime.to/search?keyword="
   @anilist-a     "https://anilist.co/search/manga?search="
   @anilist-m     "https://anilist.co/search/manga?search="
   @mdex          "https://mangadex.org/titles/?q="
   @mal           "https://myanimelist.net/search/all?q="
   @9anime-l      "https://9anime.to/updated"
   @yugen-l       "https://yugen.to/latest/"
   @mdex-l        "https://mangadex.org/titles/feed"
   @mal-s         "https://myanimelist.net/anime/season/schedule"
   @shiro         "https://shiro.is/home"
)

# ---------------------------------------------------------------------------------------------

create_mern_app() {
   local color1="\e[1;36;40m";
   local color2="\e[5;37;46m";
   local reset="\e[0m";
   mkdir "$1" && z "$1";
   mkdir client server;
   ::git -m;
   echo -e "\n${color1}Generated .gitignore${reset}\n";
   echo -e "${color1}Creating React App in 'client'${reset}\n\n";
   z client;
   pnpm create vite ./ --template react-ts;
   pnpm i;
   pnpm add -D postcss cssnano tailwindcss@latest autoprefixer concurrently;
   ::git --ra;
   echo -e "\n\n${color1}Creating server in 'server'${reset}\n\n";
   z \.\./server;
   npm init -y;
   pnpm add body-parser cors express mongoose nodemon dotenv;
   z \.\.;
   echo -e "\n\n${color2}** $1 Generated **${reset}\n";
}

# ---------------------------------------------------------------------------------------------

installer() {
   while getopts ":h" opt; do
   case ${opt} in
      h )
         echo "Usage:"
         echo "    pip -h                      Display this help message."
         echo "    pip install <package>       Install <package>."
         return 0
         ;;
      \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      return 1
      ;;
   esac
   done
   shift $((OPTIND -1))

   subcommand=$1; shift  # Remove 'pip' from the argument list
   case "$subcommand" in
   # Parse options to the install sub command
   install)
      package=$1; shift  # Remove 'install' from the argument list
      echo "installing $package"

      # Process package options
      while getopts ":t:" opt; do
         case ${opt} in
         t )
            echo "installing $package at $OPTARG"
            ;;
         \? )
            echo "Invalid Option: -$OPTARG" 1>&2
            return 1
            ;;
         : )
            echo "Invalid Option: -$OPTARG requires an argument" 1>&2
            return 1
            ;;
         esac
      done
      shift $((OPTIND -1))
      ;;
   esac
}

# ---------------------------------------------------------------------------------------------

colours() {
   for clbg in {40..47} {100..107} 49 ; do
      #Foreground
      for clfg in {30..37} {90..97} 39 ; do
         #Formatting
         for attr in 0 1 2 4 5 7 ; do
            #Print the result
            echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
         done
         echo #Newline
      done
   done
}

# ---------------------------------------------------------------------------------------------

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
for i in $plugins; do
   source "$ROOT/zsh/$i/$i.plugin.zsh" 
done

# source $ZSH/oh-my-zsh.sh
# source ~/powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------------------------------------------------------------------------

colorscript random

# ---------------------------------------------------------------------------------------------


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source $ROOT/zsh/printer/printer.zsh
source $ROOT/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ROOT/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
# pass in x-term color value 0-255
ZSH_HIGHLIGHT_STYLES[alias]='fg=114'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=114'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=114,underline'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=114,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9'
ZSH_HIGHLIGHT_STYLES[path]='underline'
bindkey '^\t' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
