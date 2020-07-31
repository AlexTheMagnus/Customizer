#!/bin/zsh

# CREATE OR UPDATE SOFT LINKS
ln -sfn $HOME/Customizer/zsh/.zshrc $HOME/.zshrc
ln -sfn $HOME/Customizer/git/.gitconfig $HOME/.gitconfig
mkdir -p $HOME/.config/Code/User/ && ln -sfn $HOME/Customizer/code/settings.json $HOME/.config/Code/User/settings.json

# RELOAD SHELL CONFIGURATION
source $HOME/.zshrc