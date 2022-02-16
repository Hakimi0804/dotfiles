#!/bin/bash

# shellcheck source=filelist.sh
source filelist.sh
shopt -s dotglob

## Colours
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
reset='\033[0m'

pr_green()
{
	echo -e "${green}$1${reset}"
}

pr_yellow()
{
	echo -e "${yellow}$1${reset}"
}

readonly HOME
NEW_HOME=.
pr_green "Starting to update default files..."
for file in "${default[@]}"; do
	pr_yellow " - Updating $file"
	if [ -d "$file" ]; then
		cp -r "$file"/* "$NEW_HOME/${file#"$HOME"/}" 2>/dev/null
	else
		cp -r "$file" "$NEW_HOME/${file#"$HOME"/}" 2>/dev/null
	fi
	# Make directory if it doesn't exist
	if [ $? -eq 1 ]; then
		mkdir -p "$NEW_HOME/${file#"$HOME"/}"
		if [ -d "$file" ]; then
			cp -r "$file"/* "$NEW_HOME/${file#"$HOME"/}"
		else
			cp -r "$file" "$NEW_HOME/${file#"$HOME"/}"
		fi
	fi
done

echo

pr_green "Starting to update extra files..."
for file in "${extra_files[@]}"; do
	pr_yellow " - Updating $file"
	if [ -d "$file" ]; then
		cp -r "$file"/* "$NEW_HOME/${file#"$HOME"/}" 2>/dev/null
	else
		cp -r "$file" "$NEW_HOME/${file#"$HOME"/}" 2>/dev/null
	fi
	# Make directory if it doesn't exist
	if [ $? -eq 1 ]; then
		mkdir -p "$NEW_HOME/${file#"$HOME"/}"
		if [ -d "$file" ]; then
			cp -r "$file"/* "$NEW_HOME/${file#"$HOME"/}"
		else
			cp -r "$file" "$NEW_HOME/${file#"$HOME"/}"
		fi
	fi
done
