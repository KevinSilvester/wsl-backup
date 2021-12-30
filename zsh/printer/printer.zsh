# Function to print all custom commands
# Usage: 
# no arg       to print all general custom commands
# -w           to print all custom web commands
# -all         to print all general and web commands
# sources: - https://blog.mimacom.com/arrays-on-linux-shell/
#          - https://zsh.sourceforge.io/Intro/intro_4.html
#          - https://superuser.com/questions/737350/iterating-over-keys-or-k-v-pairs-in-zsh-associative-array
#          - https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags

emulate -L zsh

_printer() {
   typeset -A COMMANDS
   case $1 in
      '-w')    COMMANDS=( $ZSH_WEB_SEARCH_ENGINES ) ;;
      '-all')  COMMANDS=( $CUSTOM_COMMANDS $ZSH_WEB_SEARCH_ENGINES ) ;;
      *)       COMMANDS=( $CUSTOM_COMMANDS ) ;;
   esac
   local color1="\e[1;38;5;204m"
   local color2="\e[38;5;231m"
   local color3="\e[38;5;229m"
   local reset="\e[0m"
   local tab="     ";
   local tab2="\t\t";
   for key val in ${(@kv)COMMANDS}; do
      [[ ${#key} -gt 9 ]] && tab2="\t" || tab2="\t\t";
      printf "${tab}${color1}${key}${reset}${color2}:${reset}${tab2}${color3}${val}${reset}\n"
   done
   unset COMMANDS key val
}