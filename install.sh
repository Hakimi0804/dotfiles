#!/bin/bash

if [ ! -f filelist.sh ]; then
    rm -rf dotfiles
    git clone https://github.com/Hakimi0804/dotfiles.git || exit 1
    cd dotfiles || exit 1
    exec ./install.sh
else
    git pull
fi

# shellcheck source=filelist.sh
source filelist.sh
shopt -s dotglob

## Colours
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
reset='\033[0m'

pr_green() {
    echo -e "${green}$1${reset}"
}

pr_yellow() {
    echo -e "${yellow}$1${reset}"
}

pr_green "Installing dotfiles..."
for file in "${default[@]}"; do
    pr_yellow " - Installing $file"
    file=${file#"$HOME/"}
    if [ -d "$file" ]; then
        cp -r "$file"/* "$HOME/$file" 2>/dev/null
    else
        cp -r "$file" "$HOME/$file" 2>/dev/null
    fi
    # Make directory if it doesn't exist
    if [ $? -eq 1 ]; then
        mkdir -p "$HOME/$file"
        if [ -d "$file" ]; then
            cp -r "$file"/* "$HOME/$file"
        else
            cp -r "$file" "$HOME/$file"
        fi
    fi
done

for file in "${extra_files[@]}"; do
    pr_yellow " - Installing $file"
    file=${file#"$HOME/"}
    if [ -d "$file" ]; then
        cp -r "$file"/* "$HOME/$file" 2>/dev/null
    else
        cp -r "$file" "$HOME/$file" 2>/dev/null
    fi
    # Make directory if it doesn't exist
    if [ $? -eq 1 ]; then
        mkdir -p "$HOME/$file"
        if [ -d "$file" ]; then
            cp -r "$file"/* "$HOME/$file"
        else
            cp -r "$file" "$HOME/$file"
        fi
    fi
done

# get submodules list
submodlist=$(git submodule status | awk '{print $2}')
git submodule update --init --recursive
for submod in $submodlist; do
    pr_yellow " - Installing $submod"
    cp -r "$submod"/* "$HOME/$submod" 2>/dev/null
    if [ $? -eq 1 ]; then
        mkdir -p "$HOME/$submod"
        cp -r "$submod"/* "$HOME/$submod"
    fi
done
