#!/bin/bash

if [ "$EUID" -ne 0 ];then
	echo 'Please run as root'
	exit 1
fi


apt update -y
apt install -y \
	highlight \
	vim \
	dialog \
	snapd \
	bluez \
	bluez-tools \
	blueman

dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf

cp -v .zshrc ~/
cp -v vimrc /etc/vim/

systemctl enable snapd && systemctl start snapd
systemctl enable bluetooth && systemctl start bluetooth


containsElement () { for e in "${@:2}"; do [[ "$e" = "$1" ]] && return 0; done; return 1; }

in_array() {
	if [[ $(containsElement $1 ${@:3}) -eq 0 ]]; then
		echo "$2 "
	fi
}

in_array_exec() {
	if [[ $(containsElement $1 ${@:4}) -eq 0 ]]; then
		/bin/bash setup/$2.sh
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
	4 'Proton softwares (Beta Mail & VPN)' off 2>&1 >/dev/tty)
aptn+="$(in_array 1 'pdfid pdf-parser' $misc)"
aptn+="$(in_array 2 'gimp' $misc)"
aptn+="$(in_array_exec 3 'qbittorrent' 'qbittorrent' $misc)"
aptn+="$(in_array_exec 4 'proton' 'proton-vpn-gnome-desktop' $misc)"


dev=$(dialog --checklist 'Development:' 40 70 70 \
	10 'Softwares' off \
	11	'	VS Code' on \
	12	'	Android Studio' off \
	20 'Programming' off \
	21	'	Node.js' on 2>&1 >/dev/tty)
aptn+="$(in_array_exec 11 'vscode' 'code' $dev)"
aptn+="$(in_array_exec 12 'android-studio' '' $dev)"
aptn+="$(in_array 21 'nodejs' $dev)"

entr=$(dialog --checklist 'Social and entertainment:' 40 40 60 \
	10 'Social' on \
	11	'	Discord' on \
	12	'	WhatsApp' on \
	13	'	Telegram' on \
	20 'Entertainment' on \
	21	'	Spotify' on \
	22	'	VLC' on 2>&1 >/dev/tty)
snapn+="$(in_array 11 'discord' $entr)"
snapn+="$(in_array 12 'whatsdesk' $entr)"
snapn+="$(in_array 13 'telegram-desktop' $entr)"
snapn+="$(in_array 21 'spotify' $entr)"
snapn+="$(in_array 22 'vlc' $entr)"

exec 3>&-  # Close the temporary stream


apt update && apt install $aptn && apt upgrade
snap install $snapn
