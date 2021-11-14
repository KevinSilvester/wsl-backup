# web_search from terminal

function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=($ZSH_WEB_SEARCH_ENGINES)

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine '$1' not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL

    if [[ $1 == *anilist* ]]; then
       url="${urls[$1]}${(j:%20:)@[2,-1]}"
    else 
       url="${urls[$1]}${(j:+:)@[2,-1]}"
    fi
    
  else
    url="${urls[$1]}"
  fi

  open_command "$url"
}


# other search engine aliases
if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="web_search $key"
  done
  unset engines key
fi
