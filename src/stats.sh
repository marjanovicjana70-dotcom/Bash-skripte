#!/bin/bash
clear


printf "TOTAL CPU USAGE IS
\n
"

top -bn2 | grep '%Cpu' | tail -1 | awk -F ' ' '{print "Cpu usage: " (100 - $8) "%"}'

echo "--------------------------"

printf "TOTAL MEMORY USAGE IS

"

TOTAL_IN_KB="$(cat /proc/meminfo | head -1 | awk -F ' ' '{print $2}')" 
AVAILABLE_IN_KB="$(cat /proc/meminfo | head -3 | tail -1 | awk -F ' ' '{print $2}')"
USED_IN_KB="$(($TOTAL_IN_KB - $AVAILABLE_IN_KB))"

AVAILABLE_PERC=$(( $AVAILABLE_IN_KB * 100 / $TOTAL_IN_KB ))
USED_PERC=$(( $USED_IN_KB * 100 / $TOTAL_IN_KB))


echo "AVAILABLE MEMORY : $AVAILABLE_IN_KB KB ("$AVAILABLE_PERC"%) ----- USED MEMORY : $USED_IN_KB KB  ("$USED_PERC"%)"


echo "--------------------------"
printf "TOTAL DISK USAGE IS\n\n"
AVAILABLE_DISK="$(df -h --total | tail -1 | awk -F ' ' '{print $4}' | tr -d "G")"
USED_DISK="$(df -h --total | tail -1 | awk -F ' ' '{print $3}' | tr -d "G")"
TOTAL_DISK="$(df -h --total | tail -1 | awk -F ' ' '{print $2}' | tr -d "G")"

AVAILABLE_PERC=$(( $AVAILABLE_DISK * 100 / $TOTAL_DISK))
USED_PERC=$(($USED_DISK * 100 / $TOTAL_DISK))

echo "AVAILABLE DISK SPACE: $AVAILABLE_DISK GB ("$AVAILABLE_PERC"%) ----- USED DISK SPACE : $USED_DISK GB ("$USED_PERC"%)" 

echo "--------------------------"
printf "TOP 5 PROCESSES BY MEMORY USAGE\n"

ps aux --sort -%mem | head -6 | awk -F ' ' '{print $1 "\t" $2 "\t" $4 "\t" $11}'

echo "--------------------------"
printf "TOP 5 PROCESSES BY CPU USAGE\n"

ps aux --sort -%cpu | head -6 | awk -F ' ' '{print $1 "\t" $2 "\t" $4 "\t" $11}'
