#!/bin/bash

# apt update -y
# apt install -y \
# 	highlight \
# 	vim \
# 	dialog \
# 	snapd \
# 	bluez \
# 	bluez-tools \
# 	blueman

# dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf

# cp -v .zshrc ~/
# cp -v vimrc /etc/vim/

# systemctl enable snapd && systemctl start snapd
# systemctl enable bluetooth && systemctl start bluetooth

function in_array() {
	if [[ ${1[*]} =~ (^|[[:space:]])"$2"($|[[:space:]]) ]]; then
		return "$3 "
	else
		return ""
	fi
}

function in_array_exec() {
	if [[ ${1[*]} =~ (^|[[:space:]])"$2"($|[[:space:]]) ]]; then
		/bin/bash setup/$3.sh
		return "$4 "
	else
		return ""
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
	4 'Proton softwares (Beta Mail & VPN)' on 2>&1 >/dev/tty)

aptn+=$(in_array $misc 1 "pdfid pdf-parser")
aptn+=$(in_array $misc 2 "gimp")
aptn+=$(in_array_exec $misc 3 "qbittorrent" "qbittorrent")
aptn+=$(in_array_exec $misc 4 "proton" "proton-vpn-gnome-desktop")


dev=$(dialog --checklist 'Development:' 40 70 70 \
	10 'Softwares' off \
	11	'	VS Code' on \
	12	'	Android Studio' off \
	20 'Programming' off \
	21	'	Node.js' on 2>&1 >/dev/tty)
aptn+=$(in_array_exec $misc 11 "vscode" "code")
aptn+=$(in_array_exec $misc 12 "android-studio")
aptn+=$(in_array $dev 21 "nodejs")

entr=$(dialog --checklist 'Social and entertainment:' 40 40 60 \
	10 'Social' on \
	11	'	Discord' on \
	12	'	WhatsApp' on \
	13	'	Telegram' on \
	20 'Entertainment' on \
	21	'	Spotify' on \
	22	'	VLC' on 2>&1 >/dev/tty)
snapn+=$(in_array $entr 11 "discord")
snapn+=$(in_array $entr 12 "whatsdesk")
snapn+=$(in_array $entr 13 "telegram-desktop")
snapn+=$(in_array $entr 21 "spotify")
snapn+=$(in_array $entr 22 "vlc")

exec 3>&-  # Close the temporary stream


apt update && apt install $aptn && apt upgrade
snap install $snapn
