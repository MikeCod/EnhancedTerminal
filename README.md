## Overview

This project aims to setup my actual environment as I needed to setup many times.

### Software installed

- Development
  - [x] VS Code
  - [x] Node.js & npm

- Work software
  - [x] PDF tools
  - [x] GIMP
  - [x] LibreOffice (with gnome extension)

- Convenience Software
  - [x] qBittorrent
  - [x] VLC
  - [x] Spotify
  - [x] WhatsDesk
  - [x] Discord

- Utils
  - [x] Snap package manager
  - [x] Hex editor
  - [x] Vim

### Environment update

#### LibreOffice Template

<img src="asset/libreoffice.png" alt="libreoffice" style="max-width: 320px" />

| Element | Size (pt) | Color | Left padding (cm) | Other style |
|---|---|---|---|---|
| **Title** | 32 | Light Blue 2 | 1.4 | Font: Cantarell Light |
| **Heading 1** | 20 | Light Blue 2 | 0.8 (Border) | Border: Bottom 0.05pt, Light Blue 3 |
| **Heading 2** | 18 | Light Blue 1 | 0.4 |  |
| **Heading 3** | 16 | Dark Blue 1 | 2.0 |  |
| **Heading 4** | 14 | Dark Gray 2 | 0.2 |  |

#### Terminal Profiles

| Profile | Rendering |
|---|---|
| **Dark** | ![dark](asset/profile/dark.png){: style="max-width:280px"} |
| **Dark Sweet** | ![dark sweet](asset/profile/dark-sweet.png){: style="max-width:280px"} |
| **Dark Transparent** | ![dark transparent](asset/profile/dark-transparent.png){: style="max-width:280px"} |
| **Light** | ![light](asset/profile/light.png){: style="max-width:280px"} |
| **Light Sweet** | ![light sweet](asset/profile/light-sweet.png){: style="max-width:280px"} |
| **Light Transparent** | ![light transparent](asset/profile/light-transparent.png){: style="max-width:280px"} |

#### ZSH aliases

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

#### VSCode Keyboard Shortcuts

| Key | Command |
|---|---|
| `²` | Toggle Line Comment |
| `ctrl` + `²` | Toggle Line Comment |
| `ctrl` + `K` | Open Keyboard Shortcuts |
| `ctrl` + `N` | Rename File |

#### Additional Fonts

* Inter
* Lato
* Open Sans
* Poppins
* Roboto
* Ubuntu

#### Vim Settings

![vim](asset/vim.png)

Line numbering on

## Install

```sh
chmod +x import.sh
sudo ./import.sh
```