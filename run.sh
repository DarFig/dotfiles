#!/bin/bash

# **********************
# run
# install dotfiles
#
#
#
# v.2019.02.05
# ***********************



if [ $1 = 'spacevim' ]
then
  echo 'spacevim'
  curl -sLf https://spacevim.org/install.sh | bash
  cp ./spacevim/init.toml ~/.SpaceVim.d/init.toml
elif [ $1 = 'zsh' ]
then
  echo 'zsh'
  if $(apt)
  then
    sudo apt-get install zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ./theme.zsh-theme ~/.oh-my-zsh/themes/theme.zsh-theme
  elif $(pacman)
  then
    sudo pacman -S zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ./theme.zsh-theme ~/.oh-my-zsh/themes/theme.zsh-theme
  else
    echo "nada"
  fi
else
  echo 'nada'
fi

