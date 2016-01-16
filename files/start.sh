#!/bin/sh

cd /var/wiki
/usr/bin/git pull --rebase origin master

/usr/bin/start-cron.sh

gollum . --port 80 --live-preview
