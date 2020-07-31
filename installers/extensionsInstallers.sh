#!/bin/bash

installOhMyZsh() {
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh &>> $logFile
  bash /tmp/install-oh-my-zsh.sh --unattended &>> $logFile
  # Installing xclip for copydir and copyfile extensions
  sudo apt-get install -y xclip >> $logFile
}

installDashToPanel(){
    # Dependencies
    sudo apt install -y gnome-shell-extensions &>> $logFile

    sudo apt-get install -y chrome-gnome-shell &>> $logFile

    wget https://addons.mozilla.org/firefox/downloads/file/898030/gnome_shell_integration-10.1-an+fx-linux.xpi &>> $logFile
    mv /home/test/Desktop/gnome_shell_integration-10.1-an+fx-linux.xpi /home/test/.mozilla/firefox/1kptzoyl.default-release/extensions/chrome-gnome-shell@gnome.org.xpi #Move and rename
    # Need to be enabled manually

    # dash-to-panel installation
    firefox https://extensions.gnome.org/extension/1160/dash-to-panel/ &>> $logFile
    echo "It's time to enable dash-to-panel. Also, you are going to need to enable chrome-gnome-shell extension through firefox menu."
    read -p "Have you alredy done it? [y/n] " answer

    while [[ $answer != "y" ]]
    do
        read -p "Ok, I'll wait... Have you alredy done it? [y/n] " answer
    done
    echo "NICE!"
}