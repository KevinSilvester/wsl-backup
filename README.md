# **WSL Backup**

## **Content** [Essentials](#essentials) [ZSH](#zsh) [mlocate](#mlocate)
- [NodeJS](#nodejs)
- [Rust and Python](#rust-and-python)
- [Dotfiles](#dotfiles)
- [Other Utilities](#other-utilities)

******************************************************************************************************************

## Setup VcXSrv for use with WSL2
This set up is to enable x11 forwarding without disabling access control

**In WSL distro**
1. Install xauth, md5sum and gawk or awk
```bash
sudo apt install -y xauth coreutils gawk gnome-terminal

xauth list # this should be an empty list

magiccookie=$(echo '{some-pass-phrase}'|tr -d '\n\r'|md5sum|gawk '{print $1}')

rm ~/.Xauthority && touch ~/.Xauthority && xauth add host.docker.internal:0 . $magiccookie

cp ~/.Xauthority /mnt/c/Users/{WindowsUserName}
```

2. Set the `DISPLAY` environment variable
```bash
export DISPLAY=host.docker.internal:0
```

**In Windows host**
1. Install wget and vcxsrv using scoop
```pwsh
scoop install wget vcxsrv
```

2. Download the powershell script to create/update the inbound firelwall rules and to start the vcxsrv server
```pwsh
# create a folder in user home directory to house scripts
if (-Not (Test-Path -Path "$env:HOMEPATH\scripts")) { mkdir "$env:HOMEPATH\scripts" }

# Download the batch file
wget -O "$env:HOMEPATH\scripts\wsl-x11.bat" "https://gist.githubusercontent.com/KevinSilvester/bf6596393dac89a15ab2b3e0fd40acc9/raw/66cc2e92312439a287677a881bf23291fc1e4746/wsl-x11.bat"

# Download the powershell script
wget -O "$env:HOMEPATH\scripts\wsl-x11.ps1" "https://gist.githubusercontent.com/KevinSilvester/2976fc9bcbb716b1731ebb26af403580/raw/e69464b8df58485594e61baa2524dcc6784856c0/wsl-x11.ps1"
```

3. Run the batch file start the set up
```pwsh
"$env:HOMEPATH\scripts\wsl-x11.bat"
```
******************************************************************************************************************

## **Essentials**
#### **Sudo**
```zsh
apt update
apt-get install sudo -y
```
#### **Tools**
```zsh
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install git zsh curl
```

#### **[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)**
```zsh
sudo apt-get update && sudo apt-get upgrade
# instal omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# make zsh default shell
chsh -s $(which zsh)
```
******************************************************************************************************************

## **Create '\_\_root\_\_' folder**
```zsh
cd $HOME
git clone https://github.com/KevinSilvester/wsl-backup.git __root__
```
******************************************************************************************************************

## **ZSH**
#### **[ZSH Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**
```zsh
cd $ROOT/zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

#### **[ZSH Autocompletion](https://github.com/zsh-users/zsh-autosuggestions)**
```zsh
cd $ROOT/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git
```

#### **[k](https://github.com/supercrabtree/k)**
```zsh
cd $ROOT/zsh
git clone https://github.com/supercrabtree/k.git
```

#### **[extract](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/extract/extract.plugin.zsh)**
```zsh
cd $ROOT/zsh
mkdir extract
cd extract
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/extract/extract.plugin.zsh
```

#### **[colorize](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/colorize/colorize.plugin.zsh)**
```zsh
cd $ROOT/zsh
mkdir colorize
cd colorize
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/colorize/colorize.plugin.zsh
```

#### **ZSH Custom Theme**
```zsh
ln -s $ROOT/zsh/smushed.zsh-theme $HOME/.oh-my-zsh/custom/themes/smushed.zsh-theme
```
> Based on default Robby Russel theme and Passion theme <https://github.com/ChesterYue/ohmyzsh-theme-passion>

******************************************************************************************************************

## **mlocate**
#### **Install 'mlocate' to fix dpkg errors**
```zsh
# install mlocate
sudo bash -c "apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y clean"
sudo apt-get install mlocate
sudo updatedb

# add '/mnt' to PRUNEPATHS in /etc/updatedb.conf to avoid indexing windows files when running fix
# :q! >> exit without saving
# :wq >> exit and save
sudo vi /etc/updatedb.conf

```
#### **To fix dpgk errors run**
```zsh
sudo dpkg --configure -a
```

******************************************************************************************************************
## **NodeJS**
```zsh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts --latest-npm
```
******************************************************************************************************************

## **Rust and Python**
```zsh
# python
sudo bash -c "apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y clean"
sudo apt install python3
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

# rust
# check at https://www.rust-lang.org/tools/install
sudo bash -c "apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y clean"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

******************************************************************************************************************

## **Dotfiles**
```zsh
# remove default config
cd $HOME
rm .zshrc .zshenv .zprofile .bashrc .bash_profile .gitconfig .nanorc

# replace with new config
ln -s $ROOT/dotfiles/.zshrc $HOME/.zshrc
ln -s $ROOT/dotfiles/.zshenv $HOME/.zshenv
ln -s $ROOT/dotfiles/.zprofile $HOME/.zprofile
ln -s $ROOT/dotfiles/.bashrc $HOME/.bashrc
ln -s $ROOT/dotfiles/.bash_profile $HOME/.bash_profile
ln -s $ROOT/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $ROOT/dotfiles/.nanorc $HOME/.nanorc


```

******************************************************************************************************************

## **Other Utilities**
#### **[FZF](https://github.com/junegunn/fzf)**
```zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### **[Ranger](https://github.com/ranger/ranger)**
```zsh
sudo bash -c "apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y clean"

# ffmpeg: preview video thumbnail 
# w3m: preview html pages
# jq: preview json
# highlight: syntax highlighting
# mediainfo: info about media files
sudo apt-get install ranger ffmpeg w3m jq highlight mediainfo

## RANGER IMAGE PREVIEW DOES NOT WORK IN WSL
# ueberzug: image preview utility for ranger
# sudo apt install python3 libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev libx11-dev python3-distutil
# pip3 install ueberzug

# file icons for ranger
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

# add ranger config
echo "default_linemode devicons
set show_hidden true
set preview_images false" >> ~/.config/ranger/rc.conf
```

#### **[termimage](https://github.com/nabijaczleweli/termimage):** terminal image preview in rush
```zsh
cargo install termimage
```

#### **[neofetch](https://github.com/dylanaraps/neofetch):** view machine and distro info
```zsh
sudo apt-get neofetch
```

#### **[ncdu](https://github.com/rofl0r/ncdu):** storage usage monitor
```zsh
sudo apt install ncdu
```

**(～￣▽￣)～  (～￣▽￣)～  (～￣▽￣)～**
```zsh
sudo apt-get install cmatrix hollywood sl
```


