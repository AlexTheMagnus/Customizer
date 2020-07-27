#!/bin/bash

installOhMyZsh() {
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh &>> $logFile
  bash /tmp/install-oh-my-zsh.sh --unattended &>> $logFile
  # Installing xclip for copydir and copyfile extensions
  sudo apt-get install -y xclip >> $logFile
}

installDashToPanel(){
    wget https://extensions.gnome.org/extension-data/dash-to-paneljderose9.github.com.v30.shell-extension.zip -O /tmp/dash-to-panel.zip &>> $logFile
    uuid=$(unzip -c /tmp/dash-to-panel.zip metadata.json | grep uuid | cut -d \" -f4)
    mkdir -p ~/.local/share/gnome-shell/extensions/$uuid
    unzip -q /tmp/dash-to-panel.zip -d ~/.local/share/gnome-shell/extensions/$uuid/
    gnome-shell-extension-tool -e $uuid
}

installFiraCode() {
  sudo apt-get install -y fonts-firacode >> $logFile
}

installNerdTree() {
  git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/vendor/start/nerdtree &>> $logFile
  vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q &>> $logFile
}
