#!/bin/bash

# **********************
# run
# install dotfiles
#
#
# v.2021.02.06 refactor a funciones
# v.2019.02.26 versión inicial
# ***********************



function spacevim_install 
{
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
}

function spacevim_config
{
  curl -sLf https://spacevim.org/install.sh | bash
  vim
  cp ./spacevim/init.toml ~/.SpaceVim.d/init.toml
}

function zsh_install
{
  echo 'zsh'
  which apt >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo apt-get install zsh
  fi
  which pacman >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo pacman -S zsh
  fi
}

function zsh_config
{
  # instalamos y personalizamos
  SHELL=$(which zsh)
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  cp ./theme.zsh-theme ~/.oh-my-zsh/custom/themes/theme.zsh-theme
  # hay que poner theme en el zsh_theme
  sed -i 's/robbyrussell/theme/g' ~/.zshrc
}

function qtile_install
{
  echo 'qtile'
  which apt >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo apt-get install qtile
    #add rofi
    sudo apt install rofi
  fi
  which pacman >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    sudo pacman -S qtile
    #add rofi
    sudo pacman -S rofi
  fi
  mkdir tmp
  cd tmp
  git clone git://github.com/qtile/qtile.git
  cd qtile
  sudo pip install .
  cd ../..
  rm -rf tmp
  sudo pip install psutil
  #
}

function qtile_config 
{
  mkdir -p ~/.config/qtile
  cp -r ./qtile/* ~/.config/qtile
}

function main
{
  if [ $1 = 'spacevim' ]
  then
    spacevim_install
    spacevim_config
  elif [ $1 = 'zsh' ]
  then
    zsh_install
    zsh_config
  elif [ $1 = 'qtile' ]
  then
    qtile_install
    qtile_config
  elif [ $1 = 'vscodeConfig' ] 
  then
    ./vscode/setExtensions.sh
  else
  elif [ $1 = 'hackfont' ] 
  then
    mkdir tmp
    cd tmp
    curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    unzip Hack.zip
    rm Hack.zip
    mkdir -p ~/.local/share/fonts
    cp *.ttf ~/.local/share/fonts
    cd ..
    rm tmp
  else
    echo 'nada'
  fi
}

if [ "$#" -lt 1 ]
then
  echo "Usage: "
  echo "      $0 spacevim "
  echo "      $0 zsh"
  echo "      $0 vscodeConfig"
  echo "      $0 qtile"
  echo "      $0 hackfont"
  exit 85
else
  main $1
fi

exit 0