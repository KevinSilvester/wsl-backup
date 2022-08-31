# set fish_greeting

if status is-interactive
   set -gx ZSH                 "$HOME/.oh-my-zsh"
   set -gx ROOT                "$HOME/.config"
   set -gx C                   "/mnt/c"
   set -gx WIN_HOME            "$C/Users/kevin"
   set -gx NVM_DIR             "$HOME/.nvm"
   set -gx STARSHIP_CONFIG     "$ROOT/starship/starship.toml"
   set -gx WT_CONFIG           "$WIN_HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
   set -gx PS_CONFIG           "$WIN_HOME/Documents/PowerShell"
   set -gx WEZTERM_CONFIG      "$WIN_HOME/.config/wezterm"

   set -gx TERM                "xterm-256color"
   set -gx BAT_THEME           "gruvbox-dark"
   set -gx FZF_DEFAULT_OPTS    "--extended \
                              --layout=reverse \
                              --height=85% \
                              --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
                              --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
                              --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
   set -gx BROWSER             brave.exe
   set -gx EDITOR              "lvim"

   # GPG key
   set -gx GPG_TTY (tty)

   # Go
   set -gx GOROOT "/usr/local/go"
   set -gx GOPATH "$HOME/.go"

   # Bird
   set -gx BIRD_EGGS "$ROOT/bird/bird-eggs.json"
   set -gx BIRD_NEST "$ROOT/bird/bird-nest.json"
   set -gx BIRD_SHELL fish

   # Bun
   set -gx BUN_INSTALL "/home/kevin/.bun"

   # Homebrew
   set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
   set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
   set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
   set -gx HOMEBREW_NO_AUTO_UPDATE 1

   # pnpm
   set -gx PNPM_HOME "/home/kevin/.local/share/pnpm"

   # to run any graphical application via the terminal
   set -gx DISPLAY  (ip route list default | awk '{print $3}'):0
   # set -gx DISPLAY  (xauth list | awk '{print $1}')
   set -gx LIBGL_ALWAYS_INDIRECT  1

   fish_add_path -g  "$PNPM_HOME"
   fish_add_path -g  "$HOME/.fnm"
   fish_add_path -g  "$HOME/.bun/bin"
   fish_add_path -g  "$HOME/.cargo/bin"
   fish_add_path -g  "$HOME/.yarn/bin"
   fish_add_path -g  "$HOME/.config/yarn/global/node_modules/.bin"
   fish_add_path -g  "$HOME/.config/composer/vendor/bin"
   fish_add_path -g  "$HOME/.pyenv/bin"
   fish_add_path -g  "$HOME/.local/bin"
   fish_add_path -g  "$HOME/.nvm/bin"
   fish_add_path -g  "$HOME/.fzf/bin"
   fish_add_path -g  "/mnt/c/Users/kevin/AppData/Local/Programs/Microsoft VS Code/bin"
   fish_add_path -g  "/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application"
   fish_add_path -g  "/mnt/c/Program Files/JetBrains/IntelliJ IDEA 2021.2.2/bin"
   fish_add_path -g  "/mnt/c/Program Files/JetBrains/CLion 2021.3.3/bin"
   fish_add_path -g  "/mnt/c/Program Files/JetBrains/PhpStorm 2021.3.2/bin"
   fish_add_path -g  "/mnt/c/msys64/mingw64/bin"
   fish_add_path -g  "$HOME/.emacs.d/bin"
   fish_add_path -g  "/mnt/c/WINDOWS/system32"
   fish_add_path -g  "/mnt/c/WINDOWS"
   fish_add_path -g  "$GOROOT/bin"
   fish_add_path -g  "$GOPATH/bin"
   fish_add_path -g  "/mnt/c/Program Files/Java/jdk-11.0.2/bin"
   fish_add_path -g  "$HOMEBREW_PREFIX/bin"

# Rust
   set -gx RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/src"

   set -gx EXA_COLORS 'ga=38;5;48:gm=38;5;221:gv=38;5;223:gd=38;5;160:gt=38;5;140:da=38;5;145:sn=38;5;189:sb=38;5;189:uw=38;5;189:gw=38;5;189:tw=38;5;189:ur=38;5;189:gr=38;5;189:tr=38;5;189:ux=38;5;189:ue=38;5;189:gx=38;5;189:tx=38;5;189:'

   set -e LS_COLORS

   set -gx LS_COLORS '*=38;5;253:*.rs=38;5;166:*.go=38;5;27:.py*=38;5;228:*.html=1;49;31:*.otf=38;5;197:*.ttf=38;5;197:*.eot=38;5;197:*.woff2=38;5;197:*.woff=38;5;197:*.sass=38;5;205:*.scss=38;5;205:*.less=38;5;39:*.css=38;5;39:*.json=38;5;228:package.json=38;5;193:*.js=38;5;228:*.ts=38;5;69:*.tsx=38;5;69:*.jsx=38;5;69:*.vue=38;5;48:*.esd=38;5;60:*.dwm=38;5;60:*.swm=38;5;60:*.wim=38;5;60:*.cab=38;5;60:*.rz=38;5;60:*.7z=38;5;60:*.cpio=38;5;60:*.zoo=38;5;60:*.ace=38;5;60:*.alz=38;5;60:*.rar=38;5;60:*.sar=38;5;60:*.ear=38;5;60:*.war=38;5;60:*.jar=38;5;60:*.rpm=38;5;60:*.deb=38;5;60:*.tz=38;5;60:*.tbz2=38;5;60:*.tbz=38;5;60:*.bz=38;5;60:*.bz2=38;5;60:*.tzst=38;5;60:*.zst=38;5;60:*.xz=38;5;60:*.lzo=38;5;60:*.lz=38;5;60:*.lrz=38;5;60:*.gz=38;5;60:*.dz=38;5;60:*.z=38;5;60:*.zip=38;5;60:*.t7z=38;5;60:*.tzo=38;5;60:*.txz=38;5;60:*.tlz=38;5;60:*.lzma=38;5;60:*.lzh=38;5;60:*.lz4=38;5;60:*.lha=38;5;60:*.taz=38;5;60:*.arj=38;5;60:*.arc=38;5;60:*.tgz=38;5;60:*.tar=38;5;60:*.zwc=38;5;183:*.sh=38;5;183:.bash*=38;5;183:.bash_profile=38;5;183:*.bash=38;5;183:.zshenv=38;5;183:.zprofile=38;5;183:.zsh*=38;5;183:.zcomp*=38;5;183:.*config=38;5;183:*.fish=38;5;183:*.zsh=38;5;183:.*rc=38;5;183:README.md=1;38;5;136:*.md=38;5;106:ex=38;5;217:ln=1;38;5;122:di=1;38;5;117:'

   set -l SEARCH_ENGINES \
     @google        "https://www.google.com/search?q=" \
     @duckduckgo    "https://www.duckduckgo.com/?q=" \
     @github        "https://github.com/search?q=" \
     @youtube       "https://www.youtube.com/results?search_query=" \
     @yugen         "https://yugen.to/search/?q=" \
     @9anime        "https://9anime.to/search?vrf=rQ1wSBPoZ8&keyword=" \
     @anilist-a     "https://anilist.co/search/manga?search=" \
     @anilist-m     "https://anilist.co/search/manga?search=" \
     @mdex          "https://mangadex.org/titles/?q=" \
     @mal           "https://myanimelist.net/search/all?q=" \
     @9anime-l      "https://9anime.to/updated" \
     @yugen-l       "https://yugen.to/latest/" \
     @mdex-l        "https://mangadex.org/titles/feed" \
     @mal-s         "https://myanimelist.net/anime/season/schedule" \
     @shiro         "https://shiro.is/home"

   for index in (seq 1 2 (count $SEARCH_ENGINES))
      set -l key $SEARCH_ENGINES[$index]
      set -l value $SEARCH_ENGINES[(math $index + 1)]
      alias "$key"="_web_search '$value'"
   end

   # Catppuccin color palette
   # --> special
   set -l foreground d7dae0
   set -l selection 3e4058

   # --> palette
   set -l teal 9dddcb
   set -l flamingo ecbfbd
   set -l magenta c6aae8
   set -l pink f0afe1
   set -l red e28c8c
   set -l peach f7c196
   set -l green b3e1a3
   set -l yellow eadda0
   set -l blue a4b9ef
   set -l gray 6e6c7c
   set -l white f7f7f7

   # Syntax Highlighting
   set -g fish_color_normal $foreground
   set -g fish_color_command $teal
   set -g fish_color_param $magenta
   set -g fish_color_keyword $red
   set -g fish_color_quote $blue
   set -g fish_color_redirection $pink
   set -g fish_color_end $peach
   set -g fish_color_error $red
   set -g fish_color_gray $gray
   set -g fish_color_selection --background=$selection
   set -g fish_color_search_match --background=$selection
   set -g fish_color_operator $pink
   set -g fish_color_escape $flamingo
   set -g fish_color_autosuggestion $gray
   set -g fish_color_cancel $red

   set -g fish_pager_color_progress $gray
   set -g fish_pager_color_prefix $pink
   set -g fish_pager_color_completion $foreground
   set -g fish_pager_color_description $gray

   # config
   alias wt-config='nvim $WT_CONFIG/settings.json'
   alias ps-config='nvim $PS_CONFIG/Microsoft.PowerShell_profile.ps1'
   alias reload='source ~/.config/fish/config.fish'
   alias nvim-config='nvim ~/.config/nvim/init.lua'
   alias lvim-config='nvim ~/.config/lvim/config.lua'
   alias zsh-config='nvim $ROOT/dotfiles/.zshrc' 
   alias bash-config='nvim $ROOT/dotfiles/.bashrc'
   alias git-config='nvim $ROOT/dotfiles/.gitconfig'
   alias fish-config='nvim $ROOT/fish/config.fish'
   alias starship-config='nvim $ROOT/starship/starship.toml'
   alias w-starship-config='nvim $WIN_HOME/.config/starship.toml'
   alias w-nvim-config='nvim $WIN_HOME/AppData/Local/nvim/init.vim'
   alias w-lvim-config='nvim $WIN_HOME/AppData/Local/lvim/config.lua'
   alias wezterm-config='nvim $WEZTERM_CONFIG/wezterm.lua'
   alias bird-eggs='nvim $BIRD_EGGS'
   alias bird-nest='nvim $BIRD_NEST'

   # exa
   # alias ls='LS_COLORS="$COL__" exa -F --no-user --group-directories-first --color=always --color-scale'
   # alias ll='LS_COLORS="$COL__" exa -F --icons --no-user --group-directories-first --color=always --color-scale'
   # alias la='LS_COLORS="$COL__" exa -laF --git --icons --no-user --group-directories-first --color=always --color-scale'
   # alias lg='LS_COLORS="$COL__" exa -aF --icons --no-user --group-directories-first --color=always --color-scale --no-permissions'
   # alias lat='LS_COLORS="$COL__" exa -aFT --icons --no-user --group-directories-first -L=2 -I="node_modules|target|.git|.next|.svelte-kit|.idea" --color=always --color-scale'
   # alias lan='LS_COLORS="$COL__" exa -laFT --icons --git --no-user --group-directories-first -L=2 -I="node_modules|target|.git|.next|.svelte-kit|.idea" --color=always --color-scale'

   alias ls='exa -F --no-user --group-directories-first --color=always --color-scale'
   alias ll='exa -F --icons --no-user --group-directories-first --color=always --color-scale'
   alias la='exa -laF --git --icons --no-user --group-directories-first --color=always --color-scale'
   alias lg='exa -aF --icons --no-user --group-directories-first --color=always --color-scale --no-permissions'
   alias lat='exa -aFT --icons --no-user --group-directories-first -L=2 -I="node_modules|target|.git|.next|.svelte-kit|.idea" --color=always --color-scale'
   alias lan='exa -laFT --icons --git --no-user --group-directories-first -L=2 -I="node_modules|target|.git|.next|.svelte-kit|.idea" --color=always --color-scale'
   # cmake helper
   alias ch='_cmake_helper'
   alias wmake='/mnt/c/Users/kevin/scoop/apps/make/current/bin/make.exe'

   # zoxide
   alias ::root='z $ROOT'
   alias ::edit-root='code $ROOT'
   alias ::y2='z ~/year-2'
   alias ::c="z $C"
   alias ::win-home="z $WIN_HOME"
   alias ::desktop="z $WIN_HOME/Desktop"
   alias ::downloads="z $WIN_HOME/Downloads"
   alias ::documents="z $WIN_HOME/Documents"
   alias ::music="z $WIN_HOME/Music"
   alias ::pictures="z $WIN_HOME/Pictures"
   alias ::videos="z $WIN_HOME/Videos"
   alias ::dkit="z $WIN_HOME/OneDrive - Dundalk Institute of Technology"
   alias ::wy2="z $WIN_HOME/OneDrive - Dundalk Institute of Technology/year-2/semester-2"
   alias ::cellar="z /home/linuxbrew/.linuxbrew/Cellar"

   # image
   alias ::img1='termimage'
   alias ::img2='viu'
   alias ::img3='display'
   alias ::img4='img2txt'

   # git
   alias remote='brave (git config --get remote.origin.url)'

   #mysql
   alias mysql-start='sudo /etc/init.d/mysql start'
   alias mysql-stop='mysqladmin -p shutdown'

   # Trash CLI
   alias tp='trash-put'
   alias te='trash-empty'
   alias tl='trash-list'
   alias tre='trash-restore'
   alias trm='trash-rm'

   # bat
   alias bcat='bat --paging=never --color=always --style=numbers'

   # fzf
   alias fzf-bat='fzf --layout=reverse --height=85% --preview "bat --paging=never --style=numbers --color=always {}"'
   alias fzf-cd='cd (fd --type directory | fzf --layout=reverse --height=85%)'
   alias fzf-nvim='fd --type f --hidden --exclude .git | fzf-tmux -p 30 --reverse | xargs nvim'

   # Windows programmes
   alias explore='explorer.exe'
   alias notepad='Notepad.exe'
   alias brave='brave.exe'
   alias idea='idea64.exe'
   alias clion='clion64.exe'
   alias phpstorm='phpstorm64.exe'

   # Windows MSYS2 GCC
   alias wg++='g++.exe'
   alias wgcc='gcc.exe'

   # Prettier
   alias prettierrc='echo -e "arrowParens: \'avoid\'
   jsxSingleQuote: true
   printWidth: 100
   quoteProps: \'as-needed\'
   semi: false
   singleQuote: true
   tabWidth: 3
   trailingComma: \'none\'
   useTabs: false
   vueIndentScriptAndStyle: false" >> .prettierrc.yaml'

   zoxide init fish | source
   starship init fish | source
   thefuck --alias | source
   set FNM_DIR "/home/kevin/.local/share/fnm"
   fnm env --use-on-cd | source

  # set -l fnm_multishell_path "/mnt/wslg/runtime-dir/fnm_multishells"

  # if [ -d $HOME/.local/share/fnm ] && [ -d $fnm_multishell_path ]
  #   for fnm_path in (bash -c "ls -A $fnm_multishell_path")
  #     set -l old_symlink (readlink $fnm_multishell_path/$fnm_path)
  #     set -l present_usr (echo $old_symlink | awk -F/ '{print $3}')

  #     if [ $present_usr != $USER ]
  #       set -l new_symlink (string replace -r '\s*home\/(\w+)\/\s*' "home/$USER/" $old_symlink)
  #       ln -sfn $fnm_multishell_path/$fnm_path $new_symlink
  #     end
  #   end
  # end
  
  # function _fnm_autoload_hook --description 'Change the function' --on-variable PWD
  #   status --is-command-substitution && return
  #     if test -f .node-version -o -f .nvmrc
  #       fnm use --silent-if-unchanged
  #     end
  # end

end

