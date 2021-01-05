#!/bin/bash
# <bitbar.title>Kill Google Backup</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Alexandre Vallières-Lagacé</bitbar.author>
# <bitbar.author.github>vallieres</bitbar.author.github>
# <bitbar.desc>Seeks and destroy the Google Backup and Restore process at interval.</bitbar.desc>
# <bitbar.image>http://i.imgur.com/Rva36NL.png</bitbar.image>
# <bitbar.abouturl></bitbar.abouturl>
#

echo '💀'
echo '---';

# File to store last kill timestamp
if [ ! -f "/tmp/lastkill.dat" ] ; then
  LASTKILL=
else
  LASTKILL=$(cat /tmp/lastkill.dat) # read value from file
fi

pid=$(ps -ef | grep "Applications/Backup and Sync.app" | grep -v grep | awk '{print $2}')

if [ ${#pid} -gt 0 ]; then
  echo "Killed Google Backup and Sync | color=red"
  ps -ef | grep "Applications/Backup and Sync.app" | grep -v grep | awk '{print $2}' | xargs kill -9
  LASTKILL=$(date '+%H:%M:%S');
  echo "$LASTKILL" > /tmp/lastkill.dat # write new kill timestamp to file
  echo "Last Kill: just now"
else
  if [ -z "$LASTKILL" ]
  then
    echo "Last Kill: not yet"
  else
    echo "Last Kill: $LASTKILL"
  fi
  
fi;
  