export ZSH="/home/wsl1/.oh-my-zsh"

ZSH_THEME="smushed"

plugins=(
   git
   dotenv
   last-working-dir
   extract
   history
   yarn
   copyfile
   node
   npm
   nvm
   zsh_reload
)


# ---------------------------------------------------------------------------------------------


# Custom file paths
hash -d C=/mnt/c
hash -d win-home=/mnt/c/Users/kevin


# ---------------------------------------------------------------------------------------------


# Custom commands
alias @ROOT="cd ~/.__root__"
alias @zsh="cd ~/.oh-my-zsh"
alias @win-home="cd ~win-home"
alias @C="cd ~C"
alias @print-cmd="print_cc"
alias @print-w-cmd="print_cwc"
alias @explore="explorer.exe"
alias @notepad="Notepad.exe"
alias @dundalk="cd ~home/OneDrive - Dundalk Institute of Technology"
alias @vite-init="pnpm create vite"

typeset -A custom_commands
custom_commands=(
   @ROOT       "\tcd ~/.__root__"
   @zsh        "\tcd ~/.oh-my-zsh"
   @win-home   "\tcd ~win-home"
   @C          "\tcd ~C"
   @print-cmd "print_commands"
   @print-w-cmd "print_search_commands"
   @explore    "\texplorer.exe"
   @notepad    "\tNotepad.exe"
   @dundalk    "\tcd ~win-home/OneDrive - Dundalk Institute of Technology"
   @vite-init  "pnpm create vite"
)


# ---------------------------------------------------------------------------------------------


# Custom search engine for web-search plugin
# source: - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
ZSH_WEB_SEARCH_ENGINES=(
   @google      "https://www.google.com/search?q="
   @duckduckgo  "https://www.duckduckgo.com/?q="
   @github      "https://github.com/search?q="
   @youtube     "https://www.youtube.com/results?search_query="
   @yugen       "https://yugen.to/search/?q="
   @9anime      "https://9anime.to/search?keyword="
   @anilist-a   "https://anilist.co/search/manga?search="
   @anilist-m   "https://anilist.co/search/manga?search="
   @mangadex    "https://mangadex.org/titles/?q="
   @mal         "https://myanimelist.net/search/all?q="
)

# Custom web commands
alias @9anime-l="open_command https://9anime.to/updated"
alias @yugen-l="open_command https://yugen.to/latest/"
alias @mangadex-l="open_command https://mangadex.org/titles/feed"
alias @mal-s="open_command https://myanimelist.net/anime/season/schedule"
alias @shir="open_command https://shiro.is/home"


typeset -A custom_web_commands
custom_web_commands=(
   @google "\tSearch on Google"
   @youtube "\tSearch on YouTube"
   @yugen "\tSearch on Yugenani"
   @yugen-l "\tView latest updates on Yugenani"
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


# ---------------------------------------------------------------------------------------------


# Function to print all custom commands
# Iteration with Array index does not work ZSH as index array start with
# sources: - https://blog.mimacom.com/arrays-on-linux-shell/
#          - https://zsh.sourceforge.io/Intro/intro_4.html
#          - https://superuser.com/questions/737350/iterating-over-keys-or-k-v-pairs-in-zsh-associative-array
#          - https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags
function print_cc() {
   local color1="$fg_bold[red]";
   local color2="$fg_bold[white]";
   local color3="$fg[green]";
   local reset="$reset_color";
   local tab="     ";
   local tab2=$'\t';
   for key val in ${(@kv)custom_commands}; do
      echo "${tab}${color1}${key}${reset}${color2}:${reset}${tab2}${color3}${val}${reset}"
   done
}

function print_cwc() {
   local color1="$fg_bold[red]";
   local color2="$fg_bold[white]";
   local color3="$fg[green]";
   local reset="$reset_color";
   local tab="     ";
   local tab2=$'\t';
   for key val in ${(@kv)custom_web_commands}; do
      echo "${tab}${color1}${key}${reset}${color2}:${reset}${tab2}${color3}${val}${reset}"
   done
}


# ---------------------------------------------------------------------------------------------


source $ZSH/oh-my-zsh.sh
source /home/wsl1/.__root__/zsh/web-search/web-search.plugin.zsh
source /home/wsl1/.__root__/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/wsl1/.__root__/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"