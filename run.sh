#!/bin/bash

# **********************
# run
# install dotfiles
#
#
#
# v.2019.02.26
# ***********************
if [ "$#" -lt 1 ]
then
  echo "Usage: "
  echo "      $0 spacevim "
  echo "      $0 zsh"
  echo "      $0 vscodeConfig"
  exit 85
fi


if [ $1 = 'spacevim' ]
then
  echo 'spacevim'
  which apt >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo apt-get install vim
  fi
  which pacman >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo pacman -S vim
  else
    echo 'nada'
  fi
  curl -sLf https://spacevim.org/install.sh | bash
  vim
  cp ./spacevim/init.toml ~/.SpaceVim.d/init.toml
elif [ $1 = 'zsh' ]
then
  echo 'zsh'
  which apt >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo apt-get install zsh
    SHELL=$(which zsh)
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ./theme.zsh-theme ~/.oh-my-zsh/custom/themes/theme.zsh-theme
    nano ~/.zshrc # hay que poner theme en el zsh_theme
  fi
  which pacman >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo pacman -S zsh
    SHELL=$(which zsh)
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ./theme.zsh-theme ~/.oh-my-zsh/custom/themes/theme.zsh-theme
    nano ~/.zshrc # hay que poner theme en el zsh_theme
  else
    echo "nada"
  fi
elif [ $1 = 'vscodeConfig' ] 
then
  ./vscode/setExtensions.sh
else
  echo 'nada'
fi

