#!/bin/bash

KEY="<your telgram token>"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TARGET="<yout telegram chat ID>" # Telegram ID of the conversation with the bot, get it from /getUpdates API

DATE_EXEC="$(date "+%d-%b-%Y-%H:%M")"
TMPFILE=/tmp/ipinfo-${DATE_EXEC}.txt

curl http://ip-api.com/json/$PAM_RHOST -s -o $TMPFILE
CITY=$(cat $TMPFILE | jq '.city' | sed 's/"//g')
REGION=$(cat $TMPFILE | jq '.regionName' | sed 's/"//g')
COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/"//g')
ORG=$(cat $TMPFILE | jq '.as' | sed 's/"//g')

TEXT="User *$PAM_USER* logged in on *$HOSTNAME* at $(date '+%Y-%m-%d %H:%M:%S %Z') from $PAM_RHOST - $ORG - $CITY, $REGION, $COUNTRY"
#Remote host: $PAM_RHOST"

PAYLOAD="chat_id=$TARGET&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"

# Run in background so the script could return immediately without blocking PAM
curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
