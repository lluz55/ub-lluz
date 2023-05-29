#!/bin/bash

LC_DIR=$HOME/.local/linux_custom/

echo "Checking if 'linux custom' exists on '$LC_DIR' folder ..."

if [ -d "$LC_DIR" ]; then
	echo "'Linux_custom' already exists, remove or change folder's name to proceed"
	sleep 3
	exit 1
fi
sleep 1

echo "Cloning 'linux_custom' into $LC_DIR ..."
# Clone repo from https://github.com/lluz55/linux_custom
git clone "https://github.com/lluz55/linux_custom $LC_DIR"

# Change to `note` branch if `note/VM`
echo "Check-in out 'note's branch ..."
cd "$LC_DIR" || echo "$LC_DIR doesn't exists! Exiting!!!" && exit 2
git checkout note

# Check if config folders already exists in $HOME/.config/
for dir in $LC_DIR.config/*/; do
	for dir2 in $HOME/.config/*/; do
		par1=$(cut -d / -f 7 <<<"$dir")
		par2=$(cut -d / -f 5 <<<"$dir2")
		if [ "$par1" = "$par2" ]; then
			match=${dir2:0:-1}.bak
			# TODO: make backup if already exists
			echo "$match"
		fi
	done
done
# Copy all folders from `linux_custom/.config` to `$HOME/.config/`
