## Overview

This project aims to setup my actual environment as I needed to setup many times.

[Softwares](#software-installed)
- [LibreOffice Template](#libreoffice-template)
- [Terminal Profiles](#terminal-profiles)
- [ZSH aliases](#zsh-aliases)
	- [Node](#node)
	- [Git](#git)
	- [Miscellaneous](#miscellaneous)
- [VSCode Keyboard Shortcuts](#vscode-keyboard-shortcuts)
- [Additional Fonts](#additional-fonts)
- [Gnome Settings](#gnome-settings)

## Install

### Complete environment
```sh
chmod +x import.sh
./import.sh
```

### ZSH only
```sh
chmod +x import-zsh.sh
./import-zsh.sh
```
*It actually update VIM and Gnome profiles too*


## Update
Once installed, check whenever you want an update :
```sh
update-zsh
```

## Software installed

- Development
  - VS Code
  - NVM, Node.js & npm

- Work software
  - GIMP
  - LibreOffice (with gnome extension)

- Convenience Software
  - VLC
  - Spotify
  - WhatsDesk (unofficial WhatsApp UI)
  - Telegram
  - Discord
  - Bluetooth & Blueman

- Utils
  - qBittorrent
  - PDF tools
  - Snap package manager
  - Hex editor
  - Vim

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

#### Node
| Command | Alias | Description |
|---|---|---|
| `nclean` | `find . -type d -name "node_modules" -exec rm {} +` | Remove all `node_modules` folders |
| `npu` or `npmu` | `npm uninstall` |
| `ntree` | `tree -I "font\|img\|node_modules" .` | List project files |
| `start` | `npm start` |
| `startdev` | `NODE_ENV=development npm start` |

#### Git
| Command | Alias | Description |
|---|---|---|
| `ga` | `git add` |
| `gco` | `git commit -m` |
| `gch` | `git checkout` |
| `gcl` | `git clone` |
| `gd` or `gdiff` | `git diff` |
| `glog` | `git log` |
| `gp` | `git push` |
| `gpdev` | `git push -u origin dev` |
| `gpdevmain` | `git push -u origin dev:main` |
| `gpmain` | `git push -u origin main` |
| `gstat` | `git status` |
| `gsw` | `git switch` |
| `pull` | `git pull` |
| `push` | `git add .`, `git status`, `git commit -m "<input>"`, `git push` | All in one |

#### Docker
| Command | Alias | Description |
|---|---|---|
| `dbuild` | `docker build` |
| `dbtag` | `docker build . -t dbtag` |
| `dcls` | `docker container ls` |
| `dc` | `docker compose` |
| `dcdefault` | `docker compose -f compose.yml up` |
| `dcdev` | `docker compose -f development.compose.yml up` |
| `dctest` | `docker compose -f test.compose.yml up` |
| `dps` or `dls` | `docker ps` |
| `dpss` or `dlss` | `docker ps --size` |
| `drun` | `docker run` |

#### Miscellaneous
| Command | Alias | Description |
|---|---|---|
| `cah` | `highlight` | Print file content highlighted according to format |
| `help [<text>]` | | Display a help. If an argument is given call `search <text>` |
| `help-recovery` |  | Display a help intended for recovery |
| `iagrep <args...>` | `grep -i $1 \| grep -i $2 ...` | Insensitive AND grep |
| `la` | `ls -lA` |
| `lb` | `ls /bin /usr/bin /usr/local/bin \| sort \| uniq \| column` | List programs |
| `lc` | `echo $?` | Last code |
| `le` | `ls -A \| grep .env \| column` | List env files |
| `ll` | `ls -l` |
| `logan` | `cat "${1:-.}" \| cut "-d " -f1,4,7 \| egrep -v [many exclusions...] \| sort \| uniq -w 13 \| sed -Erz "s/[standard log regex format...]/g"` | Analyze log file |
| `lookup` | `grep -rnw . --exclude-dir=node_modules --exclude-dir=.git --exclude=package*.json -e` | Search a text within all files including subfolders of the current directory |
| `schown <folder>`  | `sudo chown -R $(whoami):$(whoami) ` | Change ownership to current user |
| `asearch <text>`  | *function* | Search a text packages |
| `msearch <text>`  | *function* | Search a text within manual. Looking on the first page |
| `search <text>`  | `asearch()` + `msearch()` | Search a text manual and packages |

### VSCode Keyboard Shortcuts
| Key | Command |
|---|---|
| `²` | Toggle Line Comment |
| `ctrl` + `²` | Toggle Line Comment |
| `ctrl` + `K` | Open Keyboard Shortcuts |
| `ctrl` + `W` | Rename File |
| `ctrl` + `Q` | Do NOT close VSCode |

### Additional Fonts

* Inter
* Lato
* Open Sans
* Poppins
* Roboto
* Ubuntu

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
