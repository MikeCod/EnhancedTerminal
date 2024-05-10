#!/bin/bash

apt update -y
apt install -y \
	highlight \
	vim

cp -v .zshrc ~/
cp -v vimrc /etc/vim/

