export ZSH="/home/wsl1/.oh-my-zsh"

ZSH_THEME="smushed"

#  Set a default file path to open to with cd

plugins=(
   git
   dotenv
   last-working-dir
   web-search
   extract
   history
   yarn
   copyfile
   node
   npm
   nvm
   zsh_reload
)


# Function to print all custom commands
# sources: - https://blog.mimacom.com/arrays-on-linux-shell/
#          - https://zsh.sourceforge.io/Intro/intro_4.html
function print_commands() {
   # List of all command results and resutls
   typeset -A custom_commands
   custom_commands=(
      @theme2     "code ~/.oh-my-zsh/themes/theme2.zsh-theme"
      @passion    "code ~/.oh-my-zsh/themes/passion.zsh-theme"
      @rr         "code ~/.oh-my-zsh/themes/robbyrussell.zsh-theme"
      @z-config   "code ~/.zshrc"
      @b-config   "code ~/.bashrc"
      @zsh        "cd ~zsh"
      @home       "cd ~home"
      @C          "cd ~C"
      @print-commands "print_commands"
      @print-s-commands "print_search_commands"
      @explore    "explorer.exe"
      @notepad    "Notepad.exe"
      @dundalk    "cd ~home/OneDrive - Dundalk Institute of Technology"
      @vite-init  "pnpm create vite"
   )
   local color1="$fg_bold[red]";
   local color2="$fg_bold[white]";
   local color3="$fg[green]";
   local reset="$reset_color";
   local tab="     ";
   local tab2=$'\t';
   # Loop through associate array 'cusotom_commands' and print key and values of array
   for key val in ${(@kv)custom_commands}; do
      echo "${tab}${color1}${key}${reset}${color2}:${reset}${tab2}${color3}${val}${reset}"
   done
}

# Custom file paths
hash -d C=/mnt/c
hash -d home=/mnt/c/Users/kevin
hash -d zsh=/home/wsl1/.oh-my-zsh

# Custom commands
alias @smushed="code ~/.__root__/zsh/smushed.zsh-theme"
alias @z-config="code ~/.zshrc"
alias @b-config="code ~/.bashrc"
alias @zsh="cd ~zsh"
alias @home="cd ~home"
alias @C="cd ~C"
alias @print-commands="print_commands"
alias @print-s-commands="print_search_commands"
alias @explore="explorer.exe"
alias @notepad="Notepad.exe"
alias @dundalk="cd ~home/OneDrive - Dundalk Institute of Technology"
alias @vite-init="pnpm create vite"


# Custom search engine for web-search plugin
# source: - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
ZSH_WEB_SEARCH_ENGINES=(
   @youtube     "https://www.youtube.com/results?search_query="
   @yugen       "https://yugen.to/search/?q="
   @9anime      "https://9anime.to/search?keyword="
   @anilist-a   "https://anilist.co/search/manga?search="
   @anilist-m   "https://anilist.co/search/manga?search="
   @mangadex    "https://mangadex.org/titles/#"
   @mal         "https://myanimelist.net/search/all?q="
)

# Custom web commands
alias @9anime-l="open_command https://9anime.to/updated"
alias @yugen-l="open_command https://yugen.to/latest/"
alias @mangadex-l="open_command https://mangadex.org/titles/feed"
alias @mal-s="open_command https://myanimelist.net/anime/season/schedule"
alias @shir="open_command https://shiro.is/home"

function print_search_commands() {
   # Custom search commands array
   typeset -A custom_commands
   custom_commands=(
      @google "\tSearch on Google"
      @youtube "\tSearch on YouTube"
      @yugen "\tSearch on Yugenani"
      @yugen-l "View latest updates on Yugenani"
      @9anime "\tSearch on 9anime"
      @9anime-l "\tView latest updates on 9anime"
      @anilist-a "Search Anime on Anilist"
      @anilist-m "Search Manga on Anilist"
      @mangadex "\tSearch on Mangadex"
      @mangadex-l "View followed manga updates"
      @mal "\tSearch on MyAnimeList"
      @mal-s "\tView release schedule"
      @shiro "\tView anime on Shiro.is"
   )
   local color1="$fg_bold[red]";
   local color2="$fg_bold[white]";
   local color3="$fg[green]";
   local reset="$reset_color";
   local tab="     ";
   local tab2=$'\t';
   # Loop through associate array 'cusotom_commands' and print key and values of array
   for key val in ${(@kv)custom_commands}; do
      echo "${tab}${color1}${key}${reset}${color2}:${reset}${tab2}${color3}${val}${reset}"
   done
}

source $ZSH/oh-my-zsh.sh
source /home/wsl1/.__root__/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/wsl1/.__root__/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"