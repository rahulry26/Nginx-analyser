#!/bin/bash

# Check if the log file exists
LOGFILE="access.log"

if [ ! -f "$LOGFILE" ]; then
  echo "Log file $LOGFILE not found. Please ensure it is in the current directory."
  exit 1
fi

echo "Analyzing Nginx logs from $LOGFILE..."
echo

# Top 5 IP addresses with the most requests
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

# Top 5 most requested paths
echo "Top 5 most requested paths:"
awk -F\" '{print $2}' "$LOGFILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

# Top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

# Top 5 user agents
echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo
