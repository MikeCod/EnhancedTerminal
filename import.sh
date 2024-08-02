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
	hexedit \
	code \
	nodejs npm \
	pdfid pdf-parser \
	gimp \
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

# Gnome Settings
## Volume
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F1']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['F2']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['F3']"

## Screenshot / Screenrecord
gsettings set org.gnome.shell.keybindings screenshot "['F9']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift>F9']"
gsettings set org.gnome.shell.keybindings screenshot-window "['<Control>F9']"
gsettings set org.gnome.shell.keybindings show-screen-recording-ui "['<Shift><Control>F9']"

snap install \
	core \
	discord \
	whatsdesk \
	telegram-desktop \
	spotify

cp -v ./whatsdesk.desktop /opt/
desktop-file-install /opt/whatsdesk.desktop
