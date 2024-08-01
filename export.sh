#!/bin/bash

if [ "$EUID" -eq 0 ]; then
	echo 'Please do NOT run as root'
	exit 1
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
out="$SCRIPTPATH/conf/"

rm -rf "$out"
mkdir "$out" && cd "$out"

# Terminal
cp -v ~/.zshrc .
cp -v /etc/vim/vimrc .
dconf dump /org/gnome/terminal/legacy/profiles:/ > gnome-terminal-profiles.dconf

# App settings
pack() {
    cd "$1" && \
        tar cJvf "$out$2.tar.xz" * && \
        cd "$out"
}
cp -v ~/.config/Code/User/keybindings.json .
pack ~/.config/libreoffice/4/user libreoffice
pack /usr/local/share/fonts fonts
