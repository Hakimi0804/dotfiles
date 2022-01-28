#!/bin/bash

# shellcheck source=filelist.sh
source filelist.sh

## Colours
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
reset='\033[0m'

pr_green()
{
	echo -e "${green}$1${reset}"
}

readonly HOME
NEW_HOME=.
pr_green "Starting to update default files..."
for file in "${default[@]}"; do
	pr_yellow " - Updating $file"
	cp -r "$file" "$NEW_HOME/${file#"$HOME"/}"
done

pr_green "Starting to update extra files..."
for file in "${extra_files[@]}"; do
	pr_yellow " - Updating $file"
	cp -r "$file" "$NEW_HOME/${file#"$HOME"/}"
done
