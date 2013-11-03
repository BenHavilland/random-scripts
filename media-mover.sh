#!/bin/bash
#
# media-mover
#
# looks for DCIM or other media directories
# renames with a prepended date
# moves files to destination
#
# config: set the global vars below
# usage: just run it. no passed in vars
#

# directory to begin recursive search
SOURCE='/USB'
# text to look for in directory names to move
MOVE_DIRS=('DCIM*' 'DCIM')
# where the directories get moved to
DESTINATION='/z/media/'

# change the Internal Field Separator 
# so we can have dir names with spaces
SAVE_IFS="$IFS"
IFS=$'\n'

for index in "${MOVE_DIRS[@]}"
do
    echo searching "${index}"
    dirs_to_copy=($(find "${SOURCE}" -name "${index}"))

    for dir_to_copy in "${dirs_to_copy[@]}"
    do
        if [ -d "${dir_to_copy}" ]; then
            date_time=$(date +%Y%m%dT%H%M%S)
            # rename with a timestamp so we don't have overwrites
            mv -v "${dir_to_copy}" "${dir_to_copy}"-$date_time
            # move to destination
            mv -v "${dir_to_copy}"-$date_time ${DESTINATION}
            # wait one second to ensure no datetime conflicts
            sleep 1
        fi
    done
done

# restore the IFS
IFS="${SAVE_IFS}"