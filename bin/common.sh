#!/bin/false
# shellcheck shell=bash

channel_id=-1001664444944
testing_group_id=-1001299514785 # real testing group
# testing_group_id=-1001155763792 # experimental testing group
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
		find "$searchpath" -maxdepth 1 -name "$logfile" -exec rm -f {} \; &>/dev/null
	done
}

clean_id()
{
	sed -i "/channel_id=$testing_group_id/d" "$HOME/bin/common.sh"
	exit 0
}
