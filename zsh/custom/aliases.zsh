# TERMINAL USE
alias pdf='xdg-open'
alias mkae='make'

# META ALIASES
alias aliases="gedit $HOME/dotfiles/zsh/custom/aliases.zsh"
alias dotfiles-update="source $HOME/dotfiles/update.sh"
alias project_hex='cd /opt/Project_Hex && sudo ./Project_Hex.out && cd -'
alias system-upgrade='sudo apt-get upgrade && project_hex'

# DIRECTORIES
alias screenshots='nautilus /home/alex/Pictures/screenshots &'

# TEMPLATES
alias templatex="cp $HOME/dotfiles/templates/latexTemplate.tex . && mv latexTemplate.tex"

# OTHERS
alias ucossh="ssh -X i72lulem@ts.uco.es"
