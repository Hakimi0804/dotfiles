#!/bin/bash
#
# Magisk Module Template Generator by HAKIMI0804
#
##########################################################################################
#
# Usage: ./template.sh folder_name
#

if [[ $# -ne 1 ]]; then
  echo "Usage: ./template.sh <folder_name>"
  exit 1
fi

# check if directory already exists
# and prompt to delete if its empty
if [[ -d $1 ]]; then
  if [[ -z $(ls -A $1) ]]; then
    echo "Directory $1 already exists and is empty"
    read -p "Do you want to delete it? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -rf $1
    else
      exit 1
    fi
  else
    echo "Directory $1 already exists and is not empty"
    exit 1
  fi
fi

# verify that our template folder is not empty
if [[ -z $(ls -A ~/bin/template) ]]; then
  echo "Template folder is empty"
  exit 1
fi

# verify the sha256sum of the template folder files
# with magisk_template_sha256sum.txt
# if they don't match, exit
#
# make sure magisk_template_sha256sum.txt is in the same directory as this script
if [[ ! -f ~/bin/magisk_template_sha256sum.txt ]]; then
  echo "magisk_template_sha256sum.txt not found"
  exit 1
fi

# now let's verify the sha256sum of the template folder files
odir=$(pwd)
cd ~/bin
sha256sum -c ~/bin/magisk_template_sha256sum.txt
if [[ $? -ne 0 ]]; then
  cd "$odir"
  echo "Template folder sha256sum does not match"
  exit 1
fi

cd "$odir"

# make the directory and copy the files
mkdir $1
cp -r ~/bin/template/* $1
mkdir $1/system
