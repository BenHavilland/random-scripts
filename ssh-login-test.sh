#!/bin/sh

USAGE="usage: script hosts.txt ssh-username"
echo "Begin Login Test"
if [ -z "$1" ]
  then
    echo "No host list supplied"
    echo $USAGE
    exit
fi
FILE=$1
echo "Host list $FILE"
if [ -z "$2" ]
  then
    echo "No username supplied"
    echo $USAGE
    exit
fi
USER=$2
echo "User $USER"
TIMEOUT=3
# set bash var field seperator to newline
IFS="
"
# test each server
for LINE in `cat $FILE`;do
 echo "---- TESTING $LINE ----"
 OUTPUT=`ssh -o LogLevel=quiet -oConnectTimeout=$TIMEOUT -i ~/.ssh/id_rsa $USER@$LINE uname -r`
 echo $OUTPUT
done