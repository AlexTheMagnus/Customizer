#!/bin/bash

######################
# CLONING REPOSITORY #
######################
cloneCustomizer() {
    git clone --recurse-submodules -j8 git@github.com:AlexTheMagnus/Customizer.git $HOME/Customizer &>> $logFile
}

configureScript() {

    # EXTENSIONS AND PLUGINS
    echo "INSTALLING EXTENSIONS AND PLUGINS"
    installOhMyZsh & showLoading "Oh My Zsh" #N
    installDashToPanel & showLoading "Dash to Panel" #Y

    # CLONING REPOSITORY
    echo "CLONING REPOSITORY"
    cloneCustomizer & showLoading "Customizer"

    # SHELL CONFIGURATION
    sudo chsh -s /bin/zsh $USER
    zsh "$HOME/Customizer/update.sh"
}