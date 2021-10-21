# WSL Backup

## Create '.\_\_root\_\_' folder
```zsh
cd ~

# if that doesn't work find the username with 'whoami' or 'echo "$USER"'
# then clone repo into folder renamed .__root__

git clone https://github.com/KevinSilvester/wsl-backup.git .__root__
```
******************************************************************************************************************

### ZSH Syntax Highlighting
```zsh
cd ~/.__root__/zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

******************************************************************************************************************

### ZSH Autocompletion
```zsh
cd ~/.__root__/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git
```

******************************************************************************************************************

### ZSH Custom Theme
###### Based on default Robby Russel theme and Passion theme <https://github.com/ChesterYue/ohmyzsh-theme-passion>
```zsh
ln -s ~/.__root__/zsh/smushed.zsh-theme ~/.oh-my-zsh/custom/themes/smushed.zsh-theme
```

******************************************************************************************************************

### Dotfiles
```zsh
ln -s ~/.__root__/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.__root__/dotfiles/.zshrc ~/.zshrc
ln -s ~/.__root__/dotfiles/.bashrc ~/.bashrc
```


