#!/bin/bash

apt update -y
apt install -y \
	highlight \
	vim \
	pdfid \
	pdf-parser

cp -v .zshrc ~/
cp -v vimrc /etc/vim/

