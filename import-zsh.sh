#!/bin/bash

if [ "$EUID" -eq 0 ]; then
	echo "Please do NOT run as root" >&2
	exit 1
fi

SCRIPTPATH="$(
	cd -- "$(dirname "$0")" >/dev/null 2>&1
	pwd -P
)"

conf="$SCRIPTPATH/conf/"

cd $conf


# Terminal
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
cp -v .zshrc ~/ && sudo cp -v .zshrc /root/
sudo cp -v vimrc /etc/vim/
git config --global init.defaultBranch main

sed -Ei '/export ENHANCED_PATH\=/d' ~/.zshrc
echo "export ENHANCED_PATH='$SCRIPTPATH'" >> ~/.zshrc
