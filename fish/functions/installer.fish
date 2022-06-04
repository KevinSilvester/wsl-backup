# TODO:  - install program by name
#        - install all programs at once
#        - list all installed program
#        - store list of all programs in hist file
#        - check for program name in hist file before install

function installer --description "simpler installer for stuff"
   # abort function if no arguments passed in
   if [ (count $argv) -eq 0 ]
      _print -w "\nNo argument recieved 😑"
      _print -i "Type 'installer --help' for command usage and options"
      return 1
   end

   if ! [ -e $ROOT/.installer-hist.txt ]
      touch $ROOT/.installer-hist.txt
   end

   set -l _BREW   zoxide bat ripgrep fzf starship exa thefuck neovim \
                  eva sd tokei yq viu stylua fnm gcc cmake
   set -l _RUST   du-dust termimage ttyper
   set -l _GO     sqls

   set -l PROGRAMS go $_GO java rust $_RUST php composer mysql node \
                   linuxbrew $_BREW lvim emacs doomemacs llvm

   if ! [ -e $ROOT/.installer-all.txt ]
      for x in $PROGRAMS
         echo $x >> $ROOT/.installer-all.txt
      end
   end

   set -l EXPECTED_ARGS --help -h --list -l --uninstall -u --all -a $PROGRAMS

   function __check_hist --argument-names _program
      grep "^$_program\$" $ROOT/.installer-hist.txt &>/dev/null
      return $status
   end
   
   function __write_to_hist --argument-names _program
      echo $_program >> $ROOT/.installer-hist.txt
      return $status
   end

   function __display_hist
      if which bat &>/dev/null
         bcat $ROOT/.installer-hist.txt
      else
         cat $ROOT/.installer-hist.txt
      end
   end

   function __install_php
      __check_hist php && _print -i "\n\nPHP is already installed! 😑"; return 1

      _print -i "\n\n***INSTALLING PHP***"
      set -l PHP_VERSION 7.4 8.1

      _print -i "\n\nInstalling software-properties-common..."
      sudo apt -y install software-properties-common libapache2-mod-php

      [ $status = 0 ] || return 1

      _print -i "\n\nAdding ondrej/php ppa repository..."
      sudo add-apt-repository ppa:ondrej/php

      [ $status = 0 ] \
         && _print -s "\n\nRepo added ✅" \
         || _print -w "\n\nFailed to add repo ❌";
            return 1;

      _print -i "\n\nUpdating..."
      sudo apt -y update && sudo apt -y upgrade

      [ $status = 0 ] || return 1

      for ver in $PHP_VERSION
         _print -i "\n\nInstalling php$ver..."
         sudo apt -y install  php$ver php$ver-cli php$ver-common php$ver-mysql libapache2-mod-php$ver \
                              php$ver-zip php$ver-gd php$ver-mbstring php$ver-curl php$ver-xml php$ver-bcmath

         # php json is built in to php8
         [ $ver = '7*' ] && sudo apt -y install php$ver-json

         # check if installed
         which php$ver &>/dev/null \
            && _print -s "\n\nphp$ver installed ✅" \
            || _print -w "\n\nphp$ver installation falied ❌"
      end

      _print -i "\n\nSetting defualt php version"
      sudo update-alternatives --set php /usr/bin/php8.1
      _print -s "\nphp8.1 set to default ✅"
      _print -i "To change default try 'sudo update-alternatives --config php'"

      __write_to_hist php
   end

   function __install_composer
      __check_hist composer && _print -i "\n\nComposer is already installed! 😑"; return 1

      _print -i "\n\n***INSTALLING COMPOSER***"

      if ! which php &>/dev/null
         _print -w "\n\nPHP not installed! Aborting! ❌"
         return 1
      end

      if ! which unzip &>/dev/null
         _print -i "\n\nInstalling 'unzip'"
         sudo apt install unzip

         [ $status = 0 ] || _print -w "\n\n'unzip' installation failed! Aborting! ❌"; return 1;
      end

      # # download composer
      cd ~
      curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php

      # get SHA-384 hash for the latest installer from https://composer.github.io/pubkeys.html
      # to verify the downloaded installer and store as a variable
      set -l HASH (curl -sS https://composer.github.io/installer.sig)

      # check hash
      _print -i "\n\nInstallation hash:\n$HASH"


      # verify that the installation script is safe to run
      # from the composer dowload page https://getcomposer.org/download/
      php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

      # to install composer globally
      sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

      if composer &>/dev/null
         _print -s "\n'Composer' installed ✅"
         __write_to_hist composer
      else
         _print-w "\n'Composer installation failed ❌";
         return 1
      end
   end

   function __install_go
      __check_hist go && _print -i "\n\n'go' is already installed! 😑"; return 1
      
      _print -i "\n\n***INSTALLING GO***"

      set -l installer (curl -sL https://golang.org/dl/ | rg -m 1 -o -w 'go1\\.\\d{2,}\\.\\d{1,3}\\.linux\\-amd64\\.tar\\.gz')
      set -l checksum (curl -sL https://golang.org/dl/ | rg -A 5 -w "$installer" | awk '/<tt>/ {print substr($NF,9,64)}' | head -1)

      _print -i "\nDownloading 'go' installer..."
      rm -f /tmp/$installer
      wget -P /tmp/ "https://golang.org/dl/$installer"

      _print -i "\nVerifying 'go' installer..."
      # verify the downloaded installer with check sha256sum
      if [ $checksum = (sha256sum ~/tmp/$installer | awk '{print $1}') ]
         _print -s "\n'go' installer verified 👍"
      else
         _print -w "\n'go' installer unverifed! Aborting! ❌"
         return 1
      end

      _print -i "\nInstalling 'go'..."
      sudo rm -rf /usr/local/go
      sudo tar -C /usr/local -xf /tmp/$installer
      
      if [ $status -eq 0 ]
         _print -s "\n'go' installed ✅"
         _print -s "\nTo get started set these environment variables"
         _print "   export GOROOT=/usr/local/go"
         _print "   export GOPATH=\$HOME/go"
         _print "   export PATH=\$PATH:/usr/local/go/bin"
         _print -s "                or"
         _print "   set -Ux GOROOT /usr/local/go"
         _print "   set -Ux GOPATH \$HOME/go"
         _print "   fish_add_path -g /usr/local/go/bin"
         __write_to_hist go
      else
         _print -w "\nInstallation failed ❌"
      end
   end

   function __install_with_go --argument-names _repo _program
       __check_hist $_program && _print -i "\n\n'$_program' is already installed! 😑"; return 1     

      _print -i "\n***INSTALLING $(string upper $_program)"
      go install "github.com/$_repo/$_program@latest"

      [ $status -eq 0 ] \
         && _print -s "\n'$_program' installed ✅"; __write_to_hist $_program \
         || _print -w "\n'$_program' installation failed! ❌"; return 1
   end

   function __install_java
      _check_hist java && _print -i "\n\n'Java' is already installed! 😑"; return 1     
      _print -i "\n\n***INSTALLING JAVA***"

      sudo apt install openjdk-11-jdk
      sudo apt install openjdk-11-jre

      _print -s "\n'Java' installed ✅"
      __write_to_hist java
   end

   function __install_rust
      _check_hist rust && _print -i "\n\n'Rust' is already installed! 😑"; return 1
      _print -i "\n\n***INSTALLING RUST***"
      
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

      [ $status -eq 0 ] \
         && _print -s "\n'Rust' installed ✅"; __write_to_hist rust \
         || _print -w "\n'Rust' installation failed! ❌"; return 1
   end

   function __install_with_cargo --argument-names _program
       __check_hist $_program && _print -i "\n\n'$_program' is already installed! 😑"; return 1     

      _print -i "\n***INSTALLING $(string upper $_program)"
      cargo install $_program

      [ $status -eq 0 ] \
         && _print -s "\n'$_program' installed ✅"; __write_to_hist $_program \
         || _print -w "\n'$_program' installation failed! ❌"; return 1
   end

   function __install_mysql
      _check_hist mysql && _print -i "\n\n'MySQL' is already installed! 😑"; return 1     
      _print -i "\n\n***INSTALLING MYSQL***"

      sudo apt install mysql-server

      _print -s "\n'MySQL' installed ✅"

      if which mysql &>/dev/null
         _print -s "\n'MySQL' installed ✅"
         __write_to_hist mysql
      else
         _print -w "\n'MySQL' installation failed ❌"
         return 1
      end
   end

   function __install_linuxbrew
       _check_hist linuxbrew && _print -i "\n\n'Linuxbrew' is already installed! 😑"; return 1
      _print -i "\n\n***INSTALLING LINUXBREW***"

      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      
      [ $status -eq 0 ] \
         && _print -s "\n'Linuxbrew' installed ✅"; __write_to_hist linuxbrew \
         || _print -w "\n'Linuxbrew' installation failed! ❌"; return 1
   end

   function __install_with_brew --argument-names _program
      __check_hist $_program && _print -i "\n\n'$_program' is already installed! 😑"; return 1     
      _print -i "\n***INSTALLING $(string upper $_program)"

      brew install $_program

      [ $status -eq 0 ] \
         && _print -s "\n'$_program' installed ✅"; __write_to_hist $_program \
         || _print -w "\n'$_program' installation failed! ❌"; return 1
   end

   function __install_node
      _check_hist node && _print -i "\n\n'Node' is already installed! 😑"; return 1     
      fnm --version &>/dev/null || print -w "\n'fnm' is not installed! Aborting! ❌"; return 1

      _print -i "\n\n***INSTALLING NODE***"
      
      fnm install --lts
      fnm use (fnm list | awk '$3 == "lts-latest" {print $2}' | string sub -s 2)

      [ $status -eq 0 ] \
         && _print -s "\n'Node' installed ✅"; __write_to_hist node \
         || _print -w "\n'Node' installation failed! ❌"; return 1
   end

   function __install_lvim
      __check_hist lvim && _print -i "\n\n'lvim' is already installed! 😑"; return 1
      _print -i "\n\n***INSTALLING LVIM***\n"
      bash -c "$(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)"
      [ $status -eq 0 ] && _print -s "\n'lvim' installed ✅"; __write_to_hist lvim
   end

   function __install_emacs
      __check_hist emacs && _print -i "\n\n'Emacs' is already installed! 😑"; return 1
      _print -i "\n\n***INSTALLING EMACS***\n"
      
      _print -i "\nUninstalling default emacs and dependencies..."
      sudo apt remove emacs --purge emacs
      sudo apt autoremove

      _print -i "\nAdding kelleyk/emacs ppa repository..."
      sudo add-apt-repository ppa:kelleyk/emacs

      [ $status = 0 ] \
         && _print -s "\nRepo added ✅" \
         || _print -w "\nFailed to add repo ❌";
            return 1;

      _print -i "\nUpdating..."
      sudo apt -y update && sudo apt -y upgrade

      _print -i "\nInstalling 'Emacs'"
      sudo apt install emacs27

      [ $status -eq 0 ] \
         && _print -s "\n'Emacs' installed ✅"; __write_to_hist emacs \
         || _print -w "\n'Emacs' installation failed! ❌"; return 1
   end

   function __install_doomemacs
      __check_hist doomemacs && _print -i "\n\n'DoomEmacs' is already installed! 😑"; return 1
      _print -i "\n\n***INSTALLING DOOMEMACS***\n"
      
      _print -i "\nCloning 'DoomEmacs' git repo..."
      git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d

      _print -i "\nInstalling 'DoomEmacs'..."
      ~/.emacs.d/bin/doom install

      [ $status -eq 0 ] \
         && _print -s "\n'DoomEmacs' installed ✅"; __write_to_hist doomemacs \
         || _print -w "\n'DoomEmacs' installation failed! ❌"; return 1
   end

   function __install_llvm
      bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
      __check_hist lvim && _print -i "\n\n'lvim' is already installed! 😑"; return 1
      _print -i "\n\n***INSTALLING LLVM***\n"
      bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
      [ $status -eq 0 ] && _print -s "\n'LLVM' installed ✅"; __write_to_hist llvm
   end



   functions -e __check_hist
   functions -e __write_to_hist
   functions -e __display_hist
   functions -e __install_php
   functions -e __install_composer
   functions -e __install_go
   functions -e __install_with_go
   functions -e __install_java
   functions -e __install_rust
   functions -e __install_with_cargo
   functions -e __install_mysql
   functions -e __install_linuxbrew
   functions -e __install_with_brew
   functions -e __install_node
   functions -e __install_lvim
   functions -e __install_emacs
   functions -e __install_doomemacs
   functions -e __install_llvm
end
