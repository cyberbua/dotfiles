#############
# OH-MY-ZSH #
#############
export ZSH=$HOME/.oh-my-zsh

# Themes
if [ -z $DISPLAY ]; then
	ZSH_THEME="gentoo"
else
	ZSH_THEME="agnoster-mod"
fi


DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(sudo systemd zsh-syntax-highlighting)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin/core_perl:/usr/bin:$HOME/scripts"

source $ZSH/oh-my-zsh.sh

# highlighting rules
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan,bold'
#############


##################
#     ALIAS      #
##################
alias -r sudo='sudo '
alias -g gp='| grep -i'
alias -g lss='| less'
alias -r l='ls -lah --group-directories-first'

alias -r cd='pushd >/dev/null'

alias -r rf='rm -rf'
alias -r mkdir='mkdir -p'
alias -r dd='dd status=progress'
alias -r lsblk='lsblk -o NAME,LABEL,SIZE,FSTYPE,MOUNTPOINT'

alias -r S='pacaur -S'
alias -r Ss='pacaur -Ss'
alias -r Syu='pacaur -Syu'
alias -r Rns='pacaur -Rns'

alias -r cal='cal -m3'
alias -r t='tree -C'
alias -r wanip='curl ipinfo.io/ip'
alias -r lanip='ip addr show wlp2s0 | /usr/bin/grep -Po "inet \K[\d.]+"'

alias -r pastebin='curl -F c=@- https://ptpb.pw'
alias -r pastefile='curl -F c=@- https://ptpb.pw <'

alias -r share='ip addr; webfsd -Fdp 8000'
alias -r clip='xclip -selection clipboard'

alias -r qr='qrencode -t UTF8'
alias -r qrclip='xclip -o | qrencode -t UTF8'

alias -r histclean='tac ~/.zsh_history | sort -t ";" -k 2 -u | sort -o ~/.zsh_history'

# commit all changes with generic commit message for minor changes
alias -r commit='git commit -am "unimportant changes"'

##################


#############
# FUNCTIONS #
#############

# print disk usage of a directory
setopt dotglob
function duf() { 
	cd $1; du -sch * | sort -h; 
	cd - > /dev/null
}

# (un)mount using udisks2 by device path or label
function mnt() {
	if [ -b $1 ]; then
		udisksctl mount -b "$@"
	else
		udisksctl mount -b /dev/disk/by-label/"$@"
	fi
}

function umnt() {
	if [ -b $1 ]; then
		udisksctl unmount -b "$@"
	else
		udisksctl unmount -b /dev/disk/by-label/"$@"
	fi
}
#############



################
# FUZZY FINDER #
################
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_CTRL_R_OPTS='-e'
bindkey '^F' fzf-file-widget

# ALT-I - Paste the selected entry from locate output into the command line
fzf-locate-widget() {
	local selected
	if selected=$(locate / | fzf); then
		LBUFFER=$LBUFFER$selected
	fi
	zle redisplay
}
zle     -N    fzf-locate-widget
bindkey '\ei' fzf-locate-widget
################


################
#    CONGIG    #
################
# auto reload completion for new prgrams
zstyle ':completion:*' rehash true

if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" = "xfce4-terminal" ]; then
    export TERM='xterm-256color'
fi

export EDITOR='vim'
export PKGDEST="/var/cache/pacman/pkg/aur"
##################

# warn me if more than one user is logged in
if [ $(who|wc -l) -gt 1 ]; then
	echo -e "Warning! More than one user logged in:"
	who
fi

# auto tmux attach
#if [ "$TERM" != 'screen' ]; then
#	tmux has-session && exec tmux attach || exec tmux
#fi

