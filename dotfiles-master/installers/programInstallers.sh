#!/bin/bash

installGit() {
  sudo apt-get install -y git >> $logFile
}

installVim() {
  sudo apt-get install -y vim >> $logFile
}

installCurl() {
  sudo apt-get install -y curl >> $logFile
}

installNumixFolders() {
    #Dependency
	sudo apt-get install numix-icon-theme >> $logFile
    
    git clone git@github.com:AlexTheMagnus/numix-folders.git >> $logFile
   
    if [ ! -d /opt/ ]; then
        mkdir /opt/
    fi
    
    sudo mv ./numix-folders /opt/
    sudo mv /opt/numix-folders/numix-folders.desktop /usr/share/applications/
}

installProjectHex() {
    #Dependencies (make, gcc, etc...)
    sudo apt-get install build-essential

    git clone git@github.com:AlexTheMagnus/Project_Hex.git >> $logFile
       
    if [ ! -d /opt/ ]; then
        mkdir /opt/
    fi
    
    sudo mv ./Project_Hex /opt/
    cd /opt/Project_Hex/
    make
    cd -
}

installGuake() {
    sudo apt-get install -y guake
}

installCaffeine() {
    sudo apt-get install -y caffeine
}

installZsh() {
    sudo apt-get install -y zsh >> $logFile
}

installDocker() {
    sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common >> $logFile
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>> $logFile
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" >> $logFile
    sudo apt-get update >> $logFile
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io >> $logFile
    sudo usermod -aG docker $USER
}

installDockerCompose() {
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &>> $logFile
    sudo chmod +x /usr/local/bin/docker-compose
}

installNode() {
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &>> $logFile
    sudo apt-get install -y nodejs >> $logFile
}

installNpm() {
    sudo apt-get install -y npm  >> $logFile
}

installYarn() {
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>> $logFile
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list >> $logFile
    sudo apt-get update >> $logFile
    sudo apt-get install -y yarn >> $logFile
}

installPythonTools() {
    sudo apt-get install -y python-pip &>> $logFile
    sudo apt-get install -y python3-pip &>> $logFile
}

installVirtualenv() {
    sudo apt-get install -y virtualenv >> $logFile
}

installTelegram() {
    wget https://telegram.org/dl/desktop/linux -O /tmp/telegram.tar.xz &>> $logFile
    tar -C /tmp/ -xvf /tmp/telegram.tar.xz >> $logFile
    if [ ! -d /opt/Telegram ]; then
        sudo mv /tmp/Telegram /opt/
    fi

	/opt/Telegram/Telegram
	pkill Telegram
}

installDiscord() {
	wget https://discordapp.com/api/download?platform=linux&format=deb -O /tmp/discord.deb &>> $logFile
	wait
    sudo dpkg -i /tmp/discord.deb &>> $logFile
	sudo apt-get install -f -y >> $logFile
}

installFranz() {
    wget https://github.com/meetfranz/franz/releases/download/v5.4.0/franz_5.4.0_amd64.deb -O /tmp/franz.deb &>> $logFile
    sudo dpkg -i /tmp/franz.deb &>> $logFile
    sudo apt-get install -f -y >> $logFile
}

installSpotify() {
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - &>> $logFile
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list >> $logFile
    sudo apt-get update >> $logFile
    sudo apt-get install -y spotify-client-gnome-support >> $logFile
}

installMegaSync() {
    wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -O /tmp/megasync.deb &>> $logFile
    sudo dpkg -i /tmp/megasync.deb &>> $logFile
    sudo apt-get install -f -y >> $logFile
    wget https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/nautilus-megasync-xUbuntu_18.04_amd64.deb -O /tmp/megasync-nautilus-extension &>> $logFile
    sudo dpkg -i /tmp/megasync-nautilus-extension &>> $logFile
    sudo apt-get install -f -y >> $logFile
}

installTilda() {
    sudo apt-get install -y tilda >> $logFile
}

installVSCode() {
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode.deb &>> $logFile
  sudo dpkg -i /tmp/vscode.deb &>> $logFile
  sudo apt-get install -f -y >> $logFile
}