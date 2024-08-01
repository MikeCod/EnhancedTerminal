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
cd $conf

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
	blueman


# Terminal
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
cp -v .zshrc "$userpath"
cp -v vimrc /etc/vim/

# Snap package manager
systemctl enable snapd && systemctl start snapd
# Bluetooth
systemctl enable bluetooth && systemctl start bluetooth

# App settings
unpack() {
    tar xJvf "$1.tar.xz" --directory "$2"
}

unpack libreoffice "$userpath/.config/libreoffice/4/user"
unpack fonts /usr/local/share/fonts

gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F1']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['F2']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['F3']"

in_array() {
	if [[ " $3 " = *" $1 "* ]]; then
		echo "$2 "
	fi
}

in_array_exec() {
	if [[ " $4 " = *" $1 "* ]]; then
		# /bin/bash setup/$2.sh
		echo "$3 "
	fi
}

aptn=""
snapn=""

# Redirecting dialog box output to a temporary stream
exec 3>&1  # Save the place that stdout (1) points to
misc=$(dialog --checklist 'What do you want to install ?' 40 70 70 \
	1 'PDF tools' on \
	2 'GIMP' on \
	3 'qBittorrent' on \
	4 'LibreOffice' on \
	5 'Proton softwares (Beta Mail & VPN)' off 2>&1 >/dev/tty)
aptn+=$(in_array 1 'pdfid pdf-parser' "$misc")
aptn+=$(in_array 2 'gimp' "$misc")
aptn+=$(in_array_exec 3 'qbittorrent' 'qbittorrent' "$misc")
aptn+=$(in_array 4 'libreoffice libreoffice-gnome' "$misc")
aptn+=$(in_array_exec 5 'proton' 'proton-vpn-gnome-desktop' "$misc")


dev=$(dialog --checklist 'Development:' 40 70 70 \
	10 'Softwares' off \
	11	'	VS Code' on \
	12	'	Android Studio' off \
	20 'Programming' off \
	21	'	Node.js' on 2>&1 >/dev/tty)
aptn+=$(in_array 11 'code' "$dev")
aptn+=$(in_array_exec 12 'android-studio' 'android-studio' "$dev")
aptn+=$(in_array 21 'nodejs npm' "$dev")

entr=$(dialog --checklist 'Social and entertainment:' 40 40 60 \
	10 'Social' on \
	11	'	Discord' on \
	12	'	WhatsApp' on \
	13	'	Telegram' on \
	20 'Entertainment' on \
	21	'	Spotify' on \
	22	'	VLC' on 2>&1 >/dev/tty)
snapn+=$(in_array 11 'discord' "$entr")
snapn+=$(in_array 12 'whatsdesk' "$entr")
snapn+=$(in_array 13 'telegram-desktop' "$entr")
snapn+=$(in_array 21 'spotify' "$entr")
snapn+=$(in_array 22 'vlc' "$entr")

exec 3>&-  # Close the temporary stream

echo "$aptn"
echo "$snapn"

if [[ "$aptn" != "" ]]; then
	apt update && apt install -y $aptn
	apt upgrade
fi
if [[ "$snapn" != "" ]]; then
	snap install $snapn
fi

