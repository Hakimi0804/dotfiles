#!/bin/false
# shellcheck shell=bash

channel_id=-1001664444944
tgbot_home=$HOME/github-repo/mybot/telegram-bot-bash
tgupload_dir=$tgbot_home/data-bot-bash

clean_log()
{
	searchpath=$1
	logfiles=(
		"BASHBOT.log"
		"ERROR.log"
		"MESSAGE.log"
	)
	for logfile in "${logfiles[@]}"; do
		find "$searchpath" -name "$logfile" -exec rm -f {} \; &>/dev/null
	done
}
