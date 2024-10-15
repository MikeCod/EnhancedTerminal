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

sudo apt update
if [[ $? -ne 0 ]]; then
	exit 1
fi
sudo apt install -y \
	highlight \
	vim \
	dialog \
	snapd \
	bluez \
	bluez-tools \
	blueman \
	hexedit \
	csvtool \
	csvkit \
	pdfid pdf-parser poppler-utils \
	tesseract-ocr \
	gimp \
	libreoffice libreoffice-gnome \
	qbittorrent \
	vlc

cd /tmp && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && nvm install 20 && node -v && npm -v

cd $conf

# Terminal
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
cp -v .zshrc ~/ && sudo cp -v .zshrc /root/
sudo cp -v vimrc /etc/vim/
git config --global init.defaultBranch main

sed -Ei '/export ENHANCED_PATH\=/d' ~/.zshrc
echo "export ENHANCED_PATH='$SCRIPTPATH'" >> ~/.zshrc

# Snap package manager
sudo systemctl enable --now snapd && sudo systemctl enable --now snapd.apparmor
# Bluetooth
sudo systemctl enable --now blueman-mechanism

# App settings
unpack() {
	if [[ $3 == "true" ]]; then
		sudo tar xJf "$1.tar.xz" --directory "$2"
	else
		tar xJf "$1.tar.xz" --directory "$2"
	fi
}

unpack vscode ~/.config/Code/User/
unpack libreoffice ~/.config/libreoffice/4/user/
unpack fonts "/usr/local/share/fonts/" true

# Gnome Settings
## Volume
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F1']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['F2']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['F3']"

## Screenshot / Screenrecord
if [[ -z "$PRINT" ]]; then
	print=$(bash -c "read -p \"Does your keyboard have the key 'Print Screen'? [y/n] \" -n 1 c; echo \$c")
	echo
	if [[ $print == "y" ]]; then
		gsettings set org.gnome.shell.keybindings screenshot "['F9']"
		gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift>F9']"
		gsettings set org.gnome.shell.keybindings screenshot-window "['<Control>F9']"
		gsettings set org.gnome.shell.keybindings show-screen-recording-ui "['<Shift><Control>F9']"

	else
		gsettings set org.gnome.shell.keybindings screenshot "['F9']"
		gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift>F9']"
		gsettings set org.gnome.shell.keybindings screenshot-window "['<Control>F9']"
		gsettings set org.gnome.shell.keybindings show-screen-recording-ui "['<Shift><Control>F9']"
	fi
	sed -Ei '/export PRINT\=/d' ~/.zshrc
	echo "export PRINT='$print'" >> ~/.zshrc
fi

## System sounds
gsettings set org.gnome.desktop.sound event-sounds false
gsettings set org.gnome.desktop.sound input-feedback-sounds false

# https://github.com/fthx/dock-from-dash

sudo snap install \
	core \
	discord \
	whatsdesk \
	telegram-desktop \
	spotify

sudo cp -v ./whatsdesk.desktop /opt/
sudo desktop-file-install /opt/whatsdesk.desktop
