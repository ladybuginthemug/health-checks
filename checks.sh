#!/bin/bash

# Function to display section headers
print_section_header() {
  local header_text=$1
  local terminal_width=$(tput cols)
  local padding_string=""

  for ((i = 0; i < (terminal_width - ${#header_text}) / 2; i++)); do
    padding_string+="="
  done

  echo "${padding_string}${header_text}${padding_string}"
}




# Function to display network health information
network_health_check() {
  print_section_header "NETWORK INFORMATION"
  ip a

  print_section_header "OPEN PORTS"
  ss -tuln

  print_section_header "EST CONNECTIONS"
  ss -tpr


  print_section_header "SURICATA LOGS"
  # Replace '/path/to/suricata/logs' with the actual path to your Suricata logs
  sudo tail -n 10 /var/log/suricata/fast.log


  print_section_header "DOCKER INFORMATION"
  docker info

  print_section_header "RUNNING CONTAINERS"
  docker ps

  print_section_header "VIRTUAL MACHINES"
  VBoxManage list runningvms



}

# Function to display system resources and uptime information
system_resources_uptime_check() {
  print_section_header "SYSTEM UPTIME"
  uptime

  print_section_header "CPU USAGE"
  top -n 1 -b | grep "%Cpu"

  print_section_header "MEMORY USAGE"
  free -m

  print_section_header "DISK USAGE"
  df -h

}


# Function to display IAM focus checks information
iam_focus_check() {
  print_section_header "IAM USER LIST"
  awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | sort

  print_section_header "IAM GROUP LIST"
  getent group | cut -d: -f1 | sort

  print_section_header "USERS WITH SUDO ACCESS"
  grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' '\n' | sort

}

logging() {
  print_section_header "LOG FILES"
  # top log files
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
    cut -d' ' -f5- "$logfile" | sort | uniq -c | sort -nr | head -
    done
}

security_check() {
  print_section_header "RUNNING SERVICES"
  systemctl list-units --type=service --state=running --no-pager --no-legend | awk '{print $1, $2, $3}' | column -t

  print_section_header "FAILED LOGINS"
  last -f /var/log/auth.log | grep "fail\|invalid" | tail -n 5

  print_section_header "ROOTKIT CHECK"
  if [ -x "$(command -v rkhunter)" ]; then
    rkhunter --check
  else
    echo "rkhunter not installed."
  fi

}

# Check the command-line argument and call the appropriate function
case "$1" in
  help) echo "Usage: $0 [help|iam|resources|network|logs|security]" ;;
  iam) iam_focus_check ;;
  resources) system_resources_uptime_check ;;
  network) network_health_check ;;
  logs) logging ;;
  security) security_check
  exit 1
esac



