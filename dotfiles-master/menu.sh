#!/bin/bash

if [ $# -lt 0 ]; then
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
        h)  helpMessage ;;       # Help
        a)  echo "a option" ;;       # All
        i)  echo "i option" ;;       # Install programs
        c)  echo "c option" ;;       # Configure system (pluggins and extensions)
        p)  echo "p option" ;;       # Personalize system (wallpaper, theme and icons)
        l)  logFile=$OPTARG; echo "l option - arg=$logFile" ;;  # LogFile
        ?)  echo "ERROR" >&2; exit 1 ;;
    esac
done
shift "$(($OPTIND - 1))" 

echo "Executed $logFile"