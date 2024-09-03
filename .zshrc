# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    parse_git_branch() {
		git symbolic-ref --short HEAD 2> /dev/null | sed -E 's/^(\w+)/｢ %F{reset}\1%F{%(#.blue.green)} ｣ /'
    }

    prompt_symbol=㉿
    # Skull emoji for root terminal
    case "$PROMPT_ALTERNATIVE" in
        twoline)
		PROMPT=$'%F{%(#.red.green)}${debian_chroot:+$debian_chroot─}${VIRTUAL_ENV:+$(basename $VIRTUAL_ENV)─}%n%F{reset}'$prompt_symbol$'%F{%(#.orange.red)}%m %B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}\n$(parse_git_branch)%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            # Right-side prompt with exit codes and background processes
            #RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
            ;;
        oneline)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
        backtrack)
            PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
            RPROMPT=
            ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

# Node
alias start='npm start'
alias startdev='NODE_ENV=development npm start'
alias npi='npm install'
alias npmi='npm install'
alias npu='npm uninstall'
alias npmu='npm uninstall'
alias ntree='tree -I "font|img|node_modules" .'
alias nclean='find . -type d -name "node_modules" -exec rm {} +'
alias nalias='alias | egrep "npm|node" | sed -E "s/='\''(.+)'\''/\t\1/"'

# Git
alias gco='git commit -m'
alias gch='git checkout'
alias gcl='git clone'
alias ga='git add'
alias gd='git diff'
alias gdiff='git diff'
alias glog='git log'
alias pull='git pull'
alias gp='git push'
alias gpdev='git push -u origin dev'
alias gpmain='git push -u origin dev:main'
alias gstat='git status'
alias gsw='git switch'
alias galias='alias | grep git | sed -E "s/='\''(.+)'\''/\t\1/"'

# Docker
alias drun='docker run -t'
alias dbuild='docker build .'
alias dbtag='docker build . -t'
alias dps='docker ps'
alias dpss='docker ps --size'
alias dls='docker ps'
alias dlss='docker ps --size'
alias dcls='docker container ls'
alias dc='docker compose'
alias dcdefault='docker compose -f compose.yml up'
alias dcdev='docker compose -f development.compose.yml up'
alias dctest='docker compose -f test.compose.yml up'

# Misc
alias cah='highlight'
alias dd='dd status=progress'
alias le='ls -A | grep .env | column'
alias lb='ls /bin /usr/bin /usr/local/bin | sort | uniq | column'
alias lc='echo $?'
alias objdump='objdump -M intel'
alias lookup='grep -rnw . --exclude-dir=node_modules --exclude-dir=.git --exclude=package*.json -e'
alias schown='sudo chown -R $(whoami):root '
alias logan='sh -c '\''cat "${1:-.}" | cut "-d " -f1,4,7 | egrep -v "/socket.io|/check|/me|/sign-in|/sign-up|/.well-known|/favicon|/robots.txt|/apple-app-site-association|/$" | sort | uniq -w 13 | sed -Erz "s/ \[([0-9]+)\/([a-zA-Z]+)\/([0-9]+):([0-9]+):([0-9]+):([0-9]+)/\t\1 \2 \3 \4:\5/g"'\'' _'
alias aalias='alias | sed -E "s/='\''(.+)'\''/ \1/"'


pad() {
	awk 'BEGIN {FS=OFS="'"${2:=~}"'"} {$1 = sprintf("  \x1b[36;1m%-'"${1:=32}"'s\x1b[0m", $1)} 1'
}
msearch() {
	man -k "$@" | grep "(1)" | grep -i "$1" | cut "-d " -f1,3- | sed -Erz 's/- / ~ /g' | pad 4
}
asearch() {
	apt search "$@" 2> /dev/null | sed -Erz 's/\n([a-zA-Z0-9_.-]+)\/kali-rolling ([a-zA-Z0-9 +.-]+)/\1/g' | sed -Erz 's/\n  / ~ /g' | grep -i "$1" | pad 16
}
search() {
	printf "\033[1;4mManual:\033[0m\n"
	msearch $@

	printf "\n\033[1;4mPackages:\033[0m\n"
	asearch $@
}

push() {
	git add .
	if [[ $(git status) == *"nothing to commit"* ]]; then
		echo "Already up to date."
		return 1
	fi
	git status
	echo -n "Comment: "
	read comment
	git commit -m "$comment"
	git push $1 $2
}

update() {
	folder="EnhancedUnix"
    mkdir -p ~/.config
	cd ~/.config
	if [ -d "$folder" ]; then
		cd $folder
		git pull origin main
		if [ $? -ne 0 ]; then
			return
		fi
	else
		git clone https://github.com/MikeCod/EnhancedTerminal.git $folder
		if [ $? -ne 0 ]; then
			return
		fi
		cd $folder
	fi
    
	cp .zshrc ~/.zshrc
	echo "Run the command below to update your current terminal:
		. ~/.zshrc
	"
}

help-recovery() {
	printf "\033[4mUsual recovery tools:\033[0m
  cryptsetup    Encrypt Drive to LUKS
  curl          Download
  dd            Copy source to destination
  fdisk         Drives details
  lsblk         Drive listing
  man           READ THE FUCKING MANUAL
  mkfs          Format partition
  search <text> Search in manual (first page)
  help [<text>] Show this help,
                Or search in manual (first page) if an argument is given

  mount <source> <mountpoint> Mount partition
  umount <mountpoint>         Unmount partition

\033[4mUsual files:\033[0m
  /dev/zero     Null byte
  /dev/random   Random byte"
}
help() {
	if [[ $1 != "" ]]; then
		search $1
		return
	fi
	printf "\033[4mCommon useful tools:\033[0m
  alias         Display aliases
  curl          Download
  dd            Copy source to destination
  fdisk         Drives details
  lb            Command listing (alias)
  lsblk         Drive listing
  jq            JSON format and filter
  man           READ THE FUCKING MANUAL
  mkfs          Format partition
  pdfunite      Merge multiple PDF
  search <text> Search in manual (first page)
  tesseract-ocr Extract text from image.
  help [<text>] Show this help,
                Or search in manual (first page) if an argument is given

  mount <source> <mountpoint> Mount partition
  umount <mountpoint>         Unmount partition

\033[4mUsual files:\033[0m
  /dev/zero     Null byte
  /dev/random   Random byte"
}

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:/snap/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
