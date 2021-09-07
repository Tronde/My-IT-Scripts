#!/bin/bash

# variables
LOGFILE="/var/www/jkastning/sites/logs/www.my-it-brain.de_access.log"
LOGFILE_GZ="/var/www/jkastning/sites/logs/www.my-it-brain.de_access.log.*"
RESPONSE_CODE="200"
ARG1=$1

# functions
filters(){
grep -w $RESPONSE_CODE \
| grep -v "\/rss\/" \
| grep -v robots.txt \
| grep -v "\.css" \
| grep -v "\.jss*" \
| grep -v "\.png" \
| grep -v "\.ico"
}

request_ips(){
awk '{print $1}'
}

request_page(){
awk '{print $7}' \
| grep -w $ARG1
}

wordcount(){
sort \
| uniq -c
}

return_kv(){
awk '{print $1, $2}'
}

get_request_page(){
echo "Page requests in current log:"
echo "====================="
cat $LOGFILE \
| filters \
| request_page \
| wordcount \
| return_kv
echo ""
}

get_request_page_all(){
echo "Page requests in all logs (last month):"
echo "==================================="
zgrep '-' --no-filename $LOGFILE $LOGFILE_GZ \
| filters \
| request_page \
| wordcount \
| return_kv
echo ""
}

# execute
get_request_page
get_request_page_all
