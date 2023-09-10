#!/bin/bash

# we process all files in var/log/ that end with log
for logfile in /var/log/*log; do

  terminal_width=$(tput cols)
  text_length=${#logfile}
  padding=$(( (terminal_width - text_length) / 2 ))
  padding_string=""
  
  for ((i = 0; i < padding; i++)); do
    padding_string+="="
    done


  echo ""
  echo "${padding_string}${logfile}${padding_string}"


# top 5 lines in each file
  cut -d' ' -f5- $logfile | sort | uniq -c | sort -nr | head -10
  done 
  

