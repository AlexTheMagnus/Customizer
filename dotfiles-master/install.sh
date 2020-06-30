#!/bin/bash

source ./installers/programInstallers.sh
source ./installers/extesionsInstallers.sh

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

########################
# CLONING REPOSITORIES #
########################
cloneCustomizer() {
  git clone --recurse-submodules -j8 git@github.com:AlexTheMagnus/Customizer.git $HOME/Customizer &>> $logFile
}

################################ SCRIPT BEGINNING ########################################

# ASK SUDO PASSWORD (TO STATE THE TERMINAL SESSION AS SUDO)
sudo ls . > $logFile

# SYSTEM UPDATE
systemUpdate & showLoading "SYSTEM UPDATE"

# INSTALLING BASIC PACKAGES
echo -e "INSTALLING BASIC PACKAGES"
installGit & showLoading "Git"
installZsh & showLoading "Zsh"
installCurl & showLoading "Curl"


# ADDING SSH KEY TO GITHUB
echo "ADDING SSH KEY TO GITHUB"
rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen -t rsa -b 4096
sshKey=$(cat ~/.ssh/id_rsa.pub)
read -s -p "Enter a personal acces token token with 'write:public_key' scope (https://github.com/settings/tokens): " githubToken
curl -i --header "Authorization: token $githubToken" --data "{\"title\": \"$(hostname)\", \"key\": \"$sshKey\"}" https://api.github.com/user/keys &>> $logFile
echo -ne "\n"
yes | ssh -T git@github.com >> $logFile

# INSTALLING OTHERS PACKAGES
installDocker & showLoading "Docker" #Y
installDockerCompose & showLoading "Docker-Compose" #Y
installNpm & showLoading "Npm" #Y
installNode & showLoading "Node" #Y
installTelegram & showLoading "Telegram" #Y
installFranz & showLoading "Franz" #Y
installDiscord & showLoading "Discord" #N
installSpotify & showLoading "Spotify" #Y
installVSCode & showLoading "VSCode" #Y
installNumixFolders & showLoading "Numix Folders" #N
installCaffeine & showLoading "Caffeine" #Y
installProjectHex & showLoading "Project_Hex" #N
installGuake & showLoading "Guake" #Y
#installMegaSync & showLoading "MegaSync"
#installTilda & showLoading "Tilda"
#installVim & showLoading "Vim"
#installYarn & showLoading "Yarn"
#installPythonTools & showLoading "Python Tools"
#installVirtualenv & showLoading "Virtualenv"


# EXTENSIONS AND PLUGINS
echo "INSTALLING EXTENSIONS AND PLUGINS"
installOhMyZsh & showLoading "Oh My Zsh" #N
installDashToPanel & showLoading "Dash to Panel" #Y
#installTheFuck & showLoading "TheFuck"
#installFiraCode & showLoading "Fira Code"
#installNerdTree & showLoading "NerdTree"

# CLONING REPOSITORIES
echo "CLONING REPOSITORY"
cloneCustomizer & showLoading "Dotfiles"

# SHELL CONFIGURATION
sudo chsh -s /bin/zsh $USER
zsh "$HOME/Customizer/dotfiles-master/update.sh"
rm -rf ~/.zcompdump* >> $logFile
exec zsh
