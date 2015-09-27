# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


#################
#    THEMES     #
#################
if [ -z $DISPLAY ]; then
	ZSH_THEME="gentoo"
else
	ZSH_THEME="agnoster-mod"
fi
################


# DEFAULT_USER="hassan"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"


################
#   PLUGINS    #
################
plugins=(git zsh-syntax-highlighting sudo)
################

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

##################
#  HIGHLIGHTING  #
##################
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
##################


##################
#     ALIAS      #
##################
alias -g gp='| grep'
alias -g lss='| less'

alias -r rf='rm -rf'

alias -r pm='pacman'
alias -r spm='sudo pacman'

alias -r S='sudo pacman -S'
alias -r Ss='pacman -Ss'
alias -r Syu='sudo pacman -Syu'

alias -r start='sudo systemctl start'
alias -r restart='sudo systemctl restart'
alias -r stop='sudo systemctl stop'
alias -r status='systemctl status'

alias -r cal='cal -m'
alias -r tree='tree -C'
alias -r wanip='curl ipinfo.io/ip'
alias -r lanip='ip addr show wlp2s0 | /usr/bin/grep -Po "inet \K[\d.]+"'
alias -r pastebin="curl -F 'sprunge=<-' http://sprunge.us"
alias -r share='echo "IP addr: "; lanip; python -m http.server 8080'
alias -r clip='xclip -selection clipboard'

alias -r mnt='udisksctl mount -b'
alias -r umnt='udisksctl unmount -b'

alias -r histclean='sort -t ";" -k 2 -u ~/.zsh_history | sort -o ~/.zsh_history'
##################


##################
#    VARIABLE    #
##################

if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" = "xfce4-terminal" ]; then
    export TERM='xterm-256color'
fi

export EDITOR='vim'
export PKGDEST="/var/cache/pacman/pkg/aur"
##################

#if [ "$TERM" != 'screen' ]; then
#	tmux has-session && exec tmux attach || exec tmux
#fi
