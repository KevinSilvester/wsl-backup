
export ZSH="$HOME/.oh-my-zsh"
export C="/mnt/c"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export FZF_DEFAULT_OPS="--extended"
export NVM_DIR="$HOME/.nvm"


ZSH_THEME="smushed"

plugins=(
   git
   dotenv
   last-working-dir
   extract
   history
   yarn
   copyfile
   zsh-syntax-highlighting
   zsh-autosuggestions
   custom-search
   k
   printer
   git-helper
   colorize
)


# ---------------------------------------------------------------------------------------------


# Custom file paths
hash -d c="$C"
hash -d win-home="$C/Users/kevin"


# ---------------------------------------------------------------------------------------------


CUSTOM_COMMANDS=(
   ::update     "sudo bash -c \"apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y clean\""
   ::root       "cd ~/__root__"
   ::zsh        "cd ~/.oh-my-zsh"
   ::win-home   "cd $C/Users/kevin"
   ::c          "cd $C"
   ::explore    "explorer.exe"
   ::notepad    "Notepad.exe"
   ::dundalk    "cd ~win-home/'OneDrive - Dundalk Institute of Technology'"
   ::vite-init  "pnpm create vite"
   ::cra        "pnpm dlx create-react-app"
   ::comp       "omz reload"
   ::y2         "cd ~/year-2"
   ::edit-root  "code ~/__root__"
   ::z-update   "omz update"
   ::img        "termimage"
   ::disk       "ncdu"
   ::train      "sl"
   ::git        "git_helper"
   ::mern       "create_mern_app"
   ::print      "printer"
   ::ip         "curl https://ipecho.net/plain; echo"
   ::port       "lsof -i "
   ::colours    "colours"
)

if [[ ${#CUSTOM_COMMANDS} -gt 0 ]]; then
   typeset -A list
   list=( $CUSTOM_COMMANDS )
   for key val in ${(@kv)list}; do
     alias "${key}"="${val}"
   done
   unset list key val
fi


# Custom search engine for web-search plugin
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
   mkdir "$1" && cd "$1";
   mkdir client server;
   ::git -m;
   echo -e "\n${color1}Generated .gitignore${reset}\n";
   echo -e "${color1}Creating React App in 'client'${reset}\n\n";
   cd client;
   ::cra \./;
   pnpm i;
   rm -rf \.git \.gitignore;
   echo -e "\n\n${color1}Creating server in 'server'${reset}\n\n";
   cd \.\./server;
   npm init -y;
   pnpm add body-parser cors express mongoose nodemon;
   cd \.\.;
   echo -e "\n\n${color2}** $1 Generated **${reset}\n";
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
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source $ZSH/oh-my-zsh.sh
