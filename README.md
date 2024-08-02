## Overview

This project aims to setup my actual environment as I needed to setup many times.

[My personal environment](#environment-update)
- [LibreOffice Template](#libreoffice-template)
- [Terminal Profiles](#terminal-profiles)
- [ZSH aliases](#zsh-aliases)
- [VSCode Keyboard Shortcuts](#vscode-keyboard-shortcuts)
- [Additional Fonts](#additional-fonts)
- [Gnome Settings](#gnome-settings)

## Install

```sh
chmod +x import.sh
sudo ./import.sh
```

## Software installed

- Development
  - [x] VS Code
  - [x] Node.js & npm

- Work software
  - [x] GIMP
  - [x] LibreOffice (with gnome extension)

- Convenience Software
  - [x] VLC
  - [x] Spotify
  - [x] WhatsDesk (unofficial WhatsApp UI)
  - [x] Telegram
  - [x] Discord
  - [x] Bluetooth & Blueman

- Utils
  - [x] qBittorrent
  - [x] PDF tools
  - [x] Snap package manager
  - [x] Hex editor
  - [x] Vim

## Environment update

### LibreOffice Template

<img src="asset/libreoffice.png" alt="libreoffice" width="320" />

| Element | Size (pt) | Color | Left padding (cm) | Other style |
|---|---|---|---|---|
| **Title** | 32 | Light Blue 2 | 1.4 | Font: Cantarell Light |
| **Heading 1** | 20 | Light Blue 2 | 0.8 (Border) | Border: Bottom 0.05pt, Light Blue 3 |
| **Heading 2** | 18 | Light Blue 1 | 0.4 |  |
| **Heading 3** | 16 | Dark Blue 1 | 2.0 |  |
| **Heading 4** | 14 | Dark Gray 2 | 0.2 |  |

### Terminal Profiles

| Dark Profile | Rendering | Light Profile | Rendering |
|---|---|---|---|
| **Dark** | <img src="asset/profile/dark.png" alt="dark" width="280" /> | **Light** | <img src="asset/profile/light.png" alt="light" width="280" /> |
| **Dark Sweet** | <img src="asset/profile/dark-sweet.png" alt="dark sweet" width="280" /> | **Light Sweet** | <img src="asset/profile/light-sweet.png" alt="light sweet" width="280" /> |
| **Dark Transparent** | <img src="asset/profile/dark-transparent.png" alt="dark transparent" width="280" /> | **Light Transparent** | <img src="asset/profile/light-transparent.png" alt="light transparent" width="280" /> |

### ZSH aliases

| Command | Alias |
|---|---|
| `pull` | `git pull` |
| `push` | `git add .`, `git status`, `git commit -m "<input>"`, `git push` |
| `cah` | `highlight` |
| `lc` | `echo $?` |
| `gcl` | `git clone` |
| `start` | `npm start` |
| `npu` or `npmu` | `npm uninstall` |
| `ll` | `ls -l` |
| `la` | `ls -lA` |

### VSCode Keyboard Shortcuts

| Key | Command |
|---|---|
| `²` | Toggle Line Comment |
| `ctrl` + `²` | Toggle Line Comment |
| `ctrl` + `K` | Open Keyboard Shortcuts |
| `ctrl` + `N` | Rename File |

### Additional Fonts

* Inter
* Lato
* Open Sans
* Poppins
* Roboto
* Ubuntu

### Vim Settings

<img src="asset/vim.png" alt="vim" width="240" />
Line numbering on

### Gnome Keyboard Shortcuts

| Key | Command |
|---|---|
| `F1` | Volume mute |
| `F2` | Volume down |
| `F3` | Volume up |
| `F9` | Full screen capture |
| `shift` + `F9` | Screen capture |
| `ctrl` + `F9` | Window Screen capture |
| `shift` + `ctrl` + `F9` | Screen recorder |
