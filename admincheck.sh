#!/bin/bash
# Author: Alex Bod
# Website: http://www.alexbod.com
# License: The GNU General Public License, version 2
# admin.sh: Admin url checking shell script

# Highlight the result
RCol='\e[0m'
Red='\e[0;31m'

# Read from a file
site=$(<site.txt)

# Check other urls
while read LINE; do
  # -o /dev/null throws away the usual output
  # --silent throws away the progress meter
  # --head makes a HEAD HTTP request, instead of GET
  # --write-out '%{http_code}\n' prints the required status code
  response=$(curl -o /dev/null --silent --head --write-out '%{http_code}' "$site$LINE")
  if [ "$response" != "404" ]
  then
    echo -e "${Red}$response${RCol} $site$LINE"
  else
    echo -e "$response $site$LINE"
  fi
done < url_list.txt
