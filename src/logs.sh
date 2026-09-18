#!/bin/bash

function input_prompt(){

read -r -p "$1 [$2]:" input
echo "${input:-$2}"

}


while true;
do
    echo "1. Specify Log Directory"
    echo "2. Specify Number of Days to Keep Logs"
    echo "3. Specify Number of Days to Keep Backup Archives"
    echo "4. Run Log Archiving Process"
    echo "5. Exit"
    echo ""

read -r -p "Chose a number [1-5] " choice

case $choice in 

    1)
    
    log_dir=$(input_prompt "Enter the log directory" "/val/log")
    if [! -d $log_dir ]; then


    fi
    ;;

    2)
    ;;

    3)
    ;;

    4)
    ;;

    5)
    ;;


esac


done