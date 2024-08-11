#!/bin/bash

if [ "$EUID" -eq 0 ]; then
	echo 'Please do NOT run as root'
	exit 1
fi

SCRIPTPATH="$(
	cd -- "$(dirname "$0")" >/dev/null 2>&1
	pwd -P
)"

conf="$SCRIPTPATH/conf/"

sudo apt update
sudo apt install -y \
	highlight \
	vim \
	dialog \
	hexedit \

cd /tmp && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && nvm install 20 && node -v && npm -v

cd $conf

# Terminal
cp -v .zshrc ~/ && sudo cp -v .zshrc /root/
sudo cp -v vimrc /etc/vim/