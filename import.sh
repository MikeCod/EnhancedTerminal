#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo 'Please run as root'
	exit 1
fi

if [[ "$1" == "" ]]; then
	echo 'Please specify a user'
	exit 1
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
conf="$SCRIPTPATH/conf/"
userpath="/home/$1"

if [ ! -d "$userpath" ]; then
	echo "This user does not seem to exist."
	echo "Checked: $userpath"
	exit 1
fi

apt update
apt install -y \
	highlight \
	vim \
	dialog \
	snapd \
	bluez \
	bluez-tools \
	blueman \
	gedit vbetool \
	hexedit \
	code \
	nodejs npm \
	pdfid pdf-parser \
	libreoffice libreoffice-gnome \
	qbittorrent \
	vlc

cd $conf

# Terminal
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
cp -v .zshrc "$userpath" && cp -v .zshrc /root/
cp -v vimrc /etc/vim/

# Snap package manager
systemctl enable snapd && systemctl start snapd && systemctl enable --now snapd.apparmor
# Bluetooth
systemctl enable bluetooth && systemctl start bluetooth

# App settings
unpack() {
    tar xJvf "$1.tar.xz" --directory "$2"
}

cp -v keybindings.json "$userpath/.config/Code/User/keybindings.json"
unpack libreoffice "$userpath/.config/libreoffice/4/user"
unpack fonts /usr/local/share/fonts

gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F1']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['F2']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['F3']"


snap install \
	discord \
	whatsdesk \
	spotify
