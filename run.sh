#!/bin/bash

# **********************
# run
# install dotfiles
#
#
# v.2021.02.12 leftwm v0.2.5
# v.2021.02.06 refactor a funciones
# v.2019.02.26 versión inicial
# ***********************
HACK_V="v2.1.0"
LEFTWM_V="0.2.5"


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
  rm -rf ./tmp
  sudo pip install psutil
  #
}

function qtile_config 
{
  mkdir -p ~/.config/qtile
  cp -r ./qtile/* ~/.config/qtile
}

function add_fonts
{
  # hack nerd-fonts
  sudo pacman -S unzip
  mkdir tmp
  cd tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/"$HACK_V"/Hack.zip
  unzip Hack.zip
  rm Hack.zip
  mkdir -p ~/.local/share/fonts
  cp *.ttf ~/.local/share/fonts
  cd ..
  rm -rf ./tmp
}

function install_environment_dependencies 
{
 sudo pacman -S gcc
 sudo pacman -S rust
 sudo pacman -S alacritty feh polybar picom conky rofi
}

function environment_install 
{
  echo "environment" 
  mkdir tmp
  ruta=$(pwd)
  cd tmp
  wget https://github.com/leftwm/leftwm/archive/"$LEFTWM_V".tar.gz
  tar -zxf ./"$LEFTWM_V".tar.gz
  rm ./"$LEFTWM_V".tar.gz
  
  cd leftwm-"$LEFTWM_V"
  
  mkdir -p ~/leftwm
  cp -r ./* ~/leftwm/

  cd ~/leftwm
 # cargo install leftwm
  cargo build --release
  sudo cp leftwm.desktop /usr/share/xsessions
 
  cd /usr/bin
  sudo ln -s ~/leftwm/target/debug/leftwm
  sudo ln -s ~/leftwm/target/debug/leftwm-worker
  sudo ln -s ~/leftwm/target/debug/leftwm-state
  echo "********** $ruta"
  cd "$ruta"
  rm -rf ./tmp
}

function environment_config
{
  add_fonts
  mkdir -p ~/.config/alacritty
  mkdir -p ~/.config/picom
  mkdir -p ~/.config/leftwm
  cp alacritty.yml ~/.config/alacritty
  cp picom.conf ~/.config/picom
  cd leftwm
  cp -r ./* ~/.config/leftwm
  cd ~/.config/leftwm/themes
  ln -s darfig-leftwm/theme current
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
  elif [ $1 = 'environment' ]
  then
    install_environment_dependencies
    environment_install
    environment_config
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
  echo "      $0 environment"
  exit 85
else
  main $1
fi

exit 0
