#!/bin/bash

source ./install.sh

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
 
while getopts 'haicpl:' OPT    # -a {argument}, -b, -c
do
    case "$OPT" in
        h)  helpMessage ;               # Help
            break ;;
        a)  if [ ! "$iFlag" ] && [ ! "$cFlag" ] && [ ! "$pFlag" ] ; then    # All
                aFlag=true;
                testScript $logFile
            fi ;;
        i)  if [ ! "$aFlag" ] ; then    # Install programs
                iFlag=true;
                echo "i option";
            fi ;;
        c)  if [ ! "$aFlag" ] ; then    # Configure system (pluggins and extensions)
                cFlag=true;
                echo "c option";   
            fi ;;
        p)  if [ ! "$aFlag" ] ; then    # Personalize system (wallpaper, theme and icons)
                pFlag=true;
                echo "p option";
            fi ;;
        l)  logFile=$OPTARG; echo "l option: arg=$logFile" ;;  # LogFile
        ?)  echo "ERROR" >&2; exit 1 ;;
    esac
done
shift "$(($OPTIND - 1))" 

echo "Executed $logFile"