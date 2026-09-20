
#!/bin/bash

#ako se log fajl nalazi unutar /var putanje mora da se koristi sudo pri izvrsavanju skripte

function input_prompt(){

read -r -p "$1 [$2]:" input
echo "${input:-$2}"

}

clear 

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
    
    log_dir=$(input_prompt "Enter the log directory" "/var/log")
    if [ ! -d $log_dir ]; then
    echo "That is not a valid directory!"
    log_dir=""
    else
    echo "Log directory set to $log_dir "

    fi
    ;;

    2)
    days_to_keep_logs=$(input_prompt "How many days of logs do you want to keep ? " "7")
    echo "Logs older than $days_to_keep_logs will be archived"
    ;;

    3)
    days_to_keep_archives=$(input_prompt "How many days of backup archives do you want to keep ? " "30")
     echo "Backup archives older than $days_to_keep_archives will be deleted"
    ;;

    4)

    if [ -z "$log_dir"  -o -z "$days_to_keep_archives" -o -z "$days_to_keep_logs" ]; then
    clear
    days_to_keep_logs=${days_to_keep_logs:-7}
    days_to_keep_archives=${days_to_keep_archives:-30}

    echo "You have to specify every option."
    else

    archive_dir="$log_dir/archive"
    mkdir -p $archive_dir

    timestamp=$(date +'%Y%m%d_%H%M%S')
    archive_file="$archive_dir/logs_archive_$timestamp.tar.gz"

    find "$log_dir" -path "$archive_dir" -prune -o -type f -mtime +$days_to_keep_logs -print0 | tar -cvzf "$archive_file" --null -T -
    echo "Logs archived  in "$archive_file" on $(date) " >> "$archive_dir/archive_log.txt"

    find "$log_dir" -path "$archive_dir" -prune -o -type f -mtime +"$days_to_keep_logs" -exec rm -f {} +

    echo "Archiving complete: $archive_file" 

    find "$archive_dir" -type f  -name "*.tar.gz" -mtime +$days_to_keep_archives -exec rm -f {} +
    echo "Archived files older than $days_to_keep_archives are deleted"
    fi
    ;;

    5)
    echo "Exiting.."
    break;
    ;;
    *)
    echo "That's an invalid option.."
    ;;


esac


done