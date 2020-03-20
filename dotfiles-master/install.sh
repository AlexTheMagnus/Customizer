#!/bin/bash

if [ $# -eq 1 ]; then
  logFile=$1
else
  echo "You need provide a path for the log file (e.g. './install /tmp/dotfilesInstallLog.txt')"
  exit 1
fi

############################
# DOING OPERATION FEEDBACK #
############################
showLoading() {
  myPid=$!
  loadingText=$1
  eraseToEndOfLine="\r\033[K"

  echo -ne "$loadingText\r"

  while kill -0 $myPid 2>/dev/null; do
    echo -ne "$loadingText.\r"
    sleep 0.5
    echo -ne "$loadingText..\r"
    sleep 0.5
    echo -ne "$loadingText...\r"
    sleep 0.5
    echo -ne "$eraseToEndOfLine"
    echo -ne "$loadingText\r"
    sleep 0.5
  done

  echo -e "$loadingText \e[1;32m\xE2\x9C\x94\e[0m"
}

#################
# SYSTEM UPDATE #
#################
systemUpdate() {
  sudo apt-get update >> $logFile
  sudo apt-get upgrade -y >> $logFile
  sudo apt-get autoremove -y >> $logFile
  sudo apt-get autoclean >> $logFile
}

#############################
# INSTALLING BASIC PACKAGES #
#############################

installGit() {
  sudo apt-get install -y git >> $logFile
}

installVim() {
  sudo apt-get install -y vim >> $logFile
}

installCurl() {
  sudo apt-get install -y curl >> $logFile
}

#sshKey sin configurar??
installNumixFolders() {
    git clone git@github.com:AlexTheMagnus/numix-folders.git >> $logFile
    sudo mv ./numix-folders /opt/
    sudo mv /opt/numix-folders/numix-folders.desktop /usr/share/applications/
}

#sshKey sin configurar??
installProjectHex() {
    git clone git@github.com:AlexTheMagnus/Project_Hex.git >> $logFile
    sudo mv ./Project_Hex /opt/
    cd /opt/Project_Hex/
    make
    sudo ./Project_Hex.out
    cd -
}

installChrome() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb-O /tmp/google-chrome-stable_current_amd64.deb-O &>> $logFile
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
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
}

installDiscord() {
    sudo apt-get install -y discord >> $logFile
}

installFranz() {
    wget https://github.com/meetfranz/franz/releases/download/v5.4.0/franz_5.4.0_amd64.deb -O /tmp/franz_5.4.0_amd64.deb &>> $logFile
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

##########################
# EXTENSIONS AND PLUGINS #
##########################
installOhMyZsh() {
  wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh &>> $logFile
  bash /tmp/install-oh-my-zsh.sh --unattended &>> $logFile
  # Installing xclip for copydir and copyfile extensions
  sudo apt-get install -y xclip >> $logFile
}

#GNOME Dash to Panel
installDashToPanel(){
    wget https://extensions.gnome.org/extension-data/dash-to-paneljderose9.github.com.v30.shell-extension.zip -O /tmp/dash-to-paneljderose9.github.com.v29.shell-extension.zip &>> $logFile
}

installFiraCode() {
  sudo apt-get install -y fonts-firacode >> $logFile
}

installTheFuck() {
  sudo -H pip3 install thefuck >> $logFile
}

installNerdTree() {
  git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/vendor/start/nerdtree &>> $logFile
  vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q &>> $logFile
}

################################
# DEVELOPMENT FOLDER STRUCTURE #
################################
developmentFolderStructure() {
  mkdir -p $HOME/development
  mkdir -p $HOME/development/devtools
  mkdir -p $HOME/development/repositories
  mkdir -p $HOME/development/repositories/sideprojects
  mkdir -p $HOME/development/repositories/codekatas
  mkdir -p $HOME/development/repositories/asl
  mkdir -p $HOME/development/repositories/university
}

########################
# CLONING REPOSITORIES #
########################
cloneDotfiles() {
  git clone --recurse-submodules -j8 git@github.com:Pablorg99/dotfiles.git $HOME/dotfiles &>> $logFile
}

# ASK SUDO PASSWORD
sudo ls . > $logFile

# SYSTEM UPDATE
systemUpdate & showLoading "SYSTEM UPDATE"

# INSTALLING BASIC PACKAGES
echo -e "INSTALLING BASIC PACKAGES"
installGit & showLoading "Git"
installZsh & showLoading "Zsh"
installCurl & showLoading "Curl"
installDocker & showLoading "Docker"
installDockerCompose & showLoading "Docker-Compose"
installNpm & showLoading "Npm"
installNode & showLoading "Node"
installTelegram & showLoading "Telegram"
installFranz & showLoading "Franz"
installDiscord & showLoading "Discord"
installSpotify & showLoading "Spotify"
installVSCode & showLoading "VSCode"
installNumixFolders & showLoading "Numix Folders"
installCaffeine & showLoading "Caffeine"
installProjectHex & showLoading "Project_Hex"
installGuake & showLoading "Guake"
installChrome & showLoading "Chrome"
#HAY QUE ACTUALIZARLO
#installMegaSync & showLoading "MegaSync"
#installTilda & showLoading "Tilda"
#installVim & showLoading "Vim"
#installYarn & showLoading "Yarn"
#installPythonTools & showLoading "Python Tools"
#installVirtualenv & showLoading "Virtualenv"


# ADDING SSH KEY TO GITHUB
echo "ADDING SSH KEY TO GITHUB"
rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen -t rsa -b 4096
sshKey=$(cat ~/.ssh/id_rsa.pub)
read -s -p "Enter a personal acces token token with 'write:public_key' scope (https://github.com/settings/tokens): " githubToken
curl -i --header "Authorization: token $githubToken" --data "{\"title\": \"$(hostname)\", \"key\": \"$sshKey\"}" https://api.github.com/user/keys &>> $logFile
echo -ne "\n"
yes | ssh -T git@github.com >> $logFile

# EXTENSIONS AND PLUGINS
echo "INSTALLING EXTENSIONS AND PLUGINS"
installOhMyZsh & showLoading "Oh My Zsh"
installDashToPanel & showLoading "Dash to Panel"
installTheFuck & showLoading "TheFuck"
#installFiraCode & showLoading "Fira Code"
#installNerdTree & showLoading "NerdTree"

# DEVELOPMENT FOLDER STRUCTURE
developmentFolderStructure & showLoading "DEVELOPMENT FOLDER STRUCTURE"

# CLONING REPOSITORIES
echo "CLONING REPOSITORIES"
cloneDotfiles & showLoading "Dotfiles"
cloneDjangoRecipes & showLoading "Django Recipes"
cloneUcoPuntoMobile & showLoading "Uco Punto Mobile"
cloneUcoPractices & showLoading "Uco Practices"

# SHELL CONFIGURATION
sudo chsh -s /bin/zsh $USER
zsh "$HOME/dotfiles/update.sh"
rm -rf ~/.zcompdump* >> $logFile
exec zsh