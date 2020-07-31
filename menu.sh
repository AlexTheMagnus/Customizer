#!/bin/bash

source ./install.sh
source ./extensions.sh

# Check no super user is used
checkNoSudo

if [ $# -lt 1 ]; then
    echo "Error" 
    echo "Add -h option for usage"
    exit 1
fi

logFile="logFile.txt"

helpMessage() {
    echo
    echo "   OPTIONS  "
    echo " ==========="
    echo " -a -> Execute full script"
    echo " -i -> Install programs"
    echo " -c -> Configure system (pluggins and extensions)"
    echo " -p -> Personalize system (wallpaper, theme and icons)"
    echo " -l <logFile.txt> -> Set logFile name (defult: logFile.txt)"
    echo " -h -> Help"
    echo
}

######################### Get all the options introduced ###############################
while getopts 'haicpl:' OPT    # -a {argument}, -b, -c
do
    case "$OPT" in
        h)  hFlag=true;;            # Help
        a)  aFlag=true;;            # All
        i)  iFlag=true;;            # Install programs
        c)  cFlag=true;;            # Configure system (extensions and settings)
        p)  pFlag=true;;            # Personalize system (wallpaper, theme and icons)
        l)  logFile=$OPTARG;;       # LogFile
        ?)  echo "ERROR - This option doesn't exist" >&2; exit ;;
    esac
done

# Help
if [ "$hFlag" ] ; then
    helpMessage;
    exit;
fi

# Check non-imcompatible options have been introduced
if [ "$aFlag" ] && ([ "$iFlag" ] || [ "$cFlag" ] || [ "$pFlag" ]) ; then
    echo "ERROR - '-a' option is not compatible with '-i', '-c' or '-p' option";
    exit 1;
fi

# All
if [ "$aFlag" ] ; then
    echo "a option";
fi

# Install programs
if [ "$iFlag" ] ; then
    testScript
fi

# Configure system
if [ "$cFlag" ] ; then
    configureScript
fi

# Personalize system
if [ "$pFlag" ] ; then
    echo "p option";
fi