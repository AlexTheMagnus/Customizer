#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "Please don't run as root"
  exit 1
fi

if [ $# -eq 1 ]; then
    logFile=$1
else
    echo "You need provide a path for the log file (e.g. './install /tmp/dotfilesInstallLog.txt')"
    exit 1
fi

source ./installers/programInstallers.sh
source ./installers/extensionsInstallers.sh

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

######################
# CLONING REPOSITORY #
######################
cloneCustomizer() {
    git clone --recurse-submodules -j8 git@github.com:AlexTheMagnus/Customizer.git $HOME/Customizer &>> $logFile
}

############################
# ADDING SSH KEY TO GITHUB #
############################
addSshKeyToGitHub() {
    echo "ADDING SSH KEY TO GITHUB"
    rm -rf ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
    ssh-keygen -t rsa -b 4096
    sshKey=$(cat ~/.ssh/id_rsa.pub)
    read -s -p "Enter a personal acces token token with 'write:public_key' scope (https://github.com/settings/tokens): " githubToken
    curl -i --header "Authorization: token $githubToken" --data "{\"title\": \"$(hostname)\", \"key\": \"$sshKey\"}" https://api.github.com/user/keys &>> $logFile
    echo -ne "\n"
    yes | ssh -T git@github.com >> $logFile
}

################################ SCRIPT BEGINNING ########################################

# ASK SUDO PASSWORD (TO STATE THE TERMINAL SESSION AS SUDO)
sudo ls . > $logFile

# DISABLE AUTOMATIC TIMEOUT FOR SUSPEND
#Get the current timeout for automatic suspend both for on battey power and when plugged in.
suspendTimeout=$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout)
suspendTimeoutBattery=$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout)

#Disable automatic suspend 
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0


# SYSTEM UPDATE
systemUpdate & showLoading "SYSTEM UPDATE"

# INSTALLING BASIC PACKAGES
echo -e "INSTALLING BASIC PACKAGES"
installGit & showLoading "Git"
installZsh & showLoading "Zsh"
installCurl & showLoading "Curl"


# ADDING SSH KEY TO GITHUB
addSshKeyToGitHub

# INSTALLING OTHERS PACKAGES
installDocker & showLoading "Docker" #Y
installDockerCompose & showLoading "Docker-Compose" #Y
installNpm & showLoading "Npm" #Y
installNode & showLoading "Node" #Y
installTelegram & showLoading "Telegram" #Y
installFranz & showLoading "Franz" #Y
installDiscord & showLoading "Discord" #Y
installSpotify & showLoading "Spotify" #Y
installVSCode & showLoading "VSCode" #Y
installNumixFolders & showLoading "Numix Folders" #Y
installCaffeine & showLoading "Caffeine" #Y
installProjectHex & showLoading "Project_Hex" #Y
installGuake & showLoading "Guake" #Y
#installMegaSync & showLoading "MegaSync"
#installTilda & showLoading "Tilda"
#installVim & showLoading "Vim"
#installYarn & showLoading "Yarn"
#installPythonTools & showLoading "Python Tools"
#installVirtualenv & showLoading "Virtualenv"

# CLONING REPOSITORY
echo "CLONING REPOSITORY"
cloneCustomizer & showLoading "Customizer"

# SHELL CONFIGURATION
sudo chsh -s /bin/zsh $USER
zsh "$HOME/Customizer/dotfiles-master/update.sh"

# RE-ENABLE AUTOMATIC SUSPEND
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout $suspendTimeout
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout $suspendTimeoutBattery

exec zsh