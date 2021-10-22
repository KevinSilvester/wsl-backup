# WSL Backup

## Create '\_\_root\_\_' folder
```zsh
cd $HOME
git clone https://github.com/KevinSilvester/wsl-backup.git __root__
```
******************************************************************************************************************

### ZSH Syntax Highlighting
```zsh
cd $HOME/__root__/zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

******************************************************************************************************************

### ZSH Autocompletion
```zsh
cd $HOME/__root__/zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git
```

******************************************************************************************************************

### ZSH Custom Theme
###### Based on default Robby Russel theme and Passion theme <https://github.com/ChesterYue/ohmyzsh-theme-passion>
```zsh
ln -s $HOME/__root__/zsh/smushed.zsh-theme $HOME/.oh-my-zsh/custom/themes/smushed.zsh-theme
```

******************************************************************************************************************

### Dotfiles
```zsh
ln -s $HOME/__root__/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $HOME/__root__/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/__root__/dotfiles/.bashrc $HOME/.bashrc
```


