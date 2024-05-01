#!/bin/bash

# If -b is supplied, backup the current executables (./firmware-upgrade.sh -b)
# If -r is supplied, restart all FSW using monit (./firmware-upgrade.sh -r)
# If -u is supplied, upgrade the firmware (./firmware-upgrade.sh -u)
# If -o is supplied, ONLY copy new backup file, do not backup current copy

if [ -z "$1" ] && [ $1 == "-b"]; then
    cp /usr/bin/dora/* /usr/bin/dora/upgrade-backups/ # copy current executables into backup files, don't upgrade anything
    exit 0

elif [ -z "$1" ] && [ $1 == "-r"]; then
    monit restart all

elif [ -z "$1" ] && [ $1 == "-u"]; then
    # Copy all executables from /home/dora/programs-upgrade/ to /usr/bin/dora/
    monit stop all
    cp /usr/bin/dora/* /usr/bin/dora/upgrade-backups/ # copy current executables into backup files
    sleep 10 # Wait 10 seconds to let monit stop the program
    rm /usr/bin/dora/* # CFDP seems to be the only one that has to actually be deleted, but we can just do all of them
    mv /home/dora/programs-upgrade/* /usr/bin/dora/
    monit start all

elif [ -z "$1" ] && [ $1 == "-u"]; then # same as above just don't copy over the backups
    monit stop all
    sleep 10 # Wait 10 seconds to let monit stop the program
    rm /usr/bin/dora/* # CFDP seems to be the only one that has to actually be deleted, but we can just do all of them
    mv /home/dora/programs-upgrade/* /usr/bin/dora/
    monit start all

fi
