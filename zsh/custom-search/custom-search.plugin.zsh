# web_search from terminal

emulate -L zsh

_web_search() {
  emulate -L zsh

  typeset -A urls
  urls=($ZSH_WEB_SEARCH_ENGINES)

  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine '$1' not supported."
    return 1
  fi

  if [[ $# -gt 1 ]]; then
    if [[ $1 == *anilist* ]]; then
       url="${urls[$1]}${(j:%20:)@[2,-1]}"
    else 
       url="${urls[$1]}${(j:+:)@[2,-1]}"
    fi
  else
    url="${urls[$1]}"
  fi

  $BROWSER "$url"
}

if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="_web_search $key"
  done
  unset engines key
fi
