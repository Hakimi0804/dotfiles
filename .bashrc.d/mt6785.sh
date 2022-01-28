#!/bin/bash

backup_list="
recovery boot lk lk2 seccfg vbmeta
"

backupessential() {
	unalias rm
	echo "starting backup, this should not take long if you use the default backup list"
	if [ -d ~/backup ]; then
		echo "cleaning up previous backup"
		rm -rf ~/backup
	fi
	mkdir -p ~/backup
	for part in $backup_list; do
		echo "dumping $part"
		mtk r $part ~/backup/$part.img &>/dev/null
		echo "dumped $part"
	done
	mtk reset
	reload
}
