#!/bin/bash

############################################
# sys_monitor.sh — simple system monitoring script
# Captures CPU, memory, disk usage and top processes
# Usage: ./sys_monitor.sh (or via cron for periodic logging)
############################################

# Config — you can edit LOGDIR if you like
LOGDIR="/var/log/sys_monitor"
HOSTNAME=$(hostname)
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
mkdir -p "$LOGDIR"

LOGFILE="${LOGDIR}/${HOSTNAME}_monitor_${TIMESTAMP}.log"

{
  echo "===== System Monitoring Report ====="
  echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Hostname: $HOSTNAME"
  echo "------------------------------------"

  # Uptime
  echo "Uptime:"
  uptime
  echo "------------------------------------"

  # CPU + Load average
  echo "CPU / Load average:"
  # show load averages
  uptime | awk -F'load average:' '{ print "Load average:" $2 }'
  echo "------------------------------------"

  # Memory usage
  echo "Memory usage:"
  free -h
  echo "------------------------------------"

  # Disk usage — all mount points
  echo "Disk usage (df -h):"
  df -h
  echo "------------------------------------"

  # (Optional) directory-level usage: root (or customize path)
  # echo "Disk usage summary (du -sh /):"
  # du -sh /
  # echo "------------------------------------"

  # Top processes by CPU
  echo "Top 10 processes by CPU usage:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 15
  echo "------------------------------------"

  # Top processes by memory
  echo "Top 10 processes by Memory usage:"
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 15
  echo "------------------------------------"

} >> "$LOGFILE"

# Also print to stdout (optional)
cat "$LOGFILE"
