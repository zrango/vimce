#!/bin/bash

if [ `which apt-get` ]; then

  if [ -z `which add-apt-repository` ]; then
    sudo apt-get install -y python-software-properties
    sudo apt-get install -y software-properties-common
  fi
  
  # 安装新版本的 vim
  sudo add-apt-repository -y ppa:jonathonf/vim
 
  # 安装必要依赖包
  sudo apt-get update
  sudo apt-get remove -y vim vim-runtime gvim
  sudo apt-get install -y git vim-nox ctags cmake build-essential python-dev python3-dev fontconfig
  
elif [ `which yum` ]; then

  sudo yum install -y git vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel
  
fi

sudo rm -rf ~/.vimrc
cp .vimrc ~

git submodule update --init --recursive

mkdir ~/.vim
sudo rm -rf ~/.vim/plugin
sudo rm -rf ~/.vim/colors
sudo rm -rf ~/.vim/bundle
sudo cp -R ./plugin ~/.vim
sudo cp -R ./colors ~/.vim
sudo cp -R ./bundle ~/.vim

mkdir -p ~/.vim/files/info
sudo chmod 666 ~/.vim/files/info

mkdir ~/.fonts
sudo rm -rf ~/.fonts/PowerlineSymbols.otf
sudo rm -rf ~/.fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf
cp ./fonts/PowerlineSymbols.otf ~/.fonts
cp ./fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf ~/.fonts
fc-cache -vf ~/.fonts

mkdir -p ~/.config/fontconfig/conf.d
sudo rm -rf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
cp ./fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim -c "PluginInstall" -c "q" -c "q"

# YouCompleteMe https://github.com/Valloric/YouCompleteMe
# sudo rm -rf ~/.ycm_extra_conf.py
# cp .ycm_extra_conf.py ~
# cd ~/.vim/bundle/YouCompleteMe
# sudo ./install.py

echo "Done!"

