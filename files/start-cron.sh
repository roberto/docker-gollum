#!/bin/sh
# start-cron.sh

touch /var/log/cron.log
cron
