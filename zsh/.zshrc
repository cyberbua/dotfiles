# VAR
ZSH=~/.zsh

# PATH
typeset -U PATH path
path=(~/bin $path)

# FPATH
typeset -U fpath
fpath=("$ZSH/functions" $fpath)


# DIRS {{{
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -r d="dirs -v"
alias -r md="mkdir -p"
alias -r rf="rm -rf"
alias -r rd=rmdir

# jump through the dir stack with 0-9
for i in {0..9}; do alias -r $i="cd ~$i"; done

eval $(dircolors)   # set LS_COLORS
LS_COLORS="$LS_COLORS:ow=01;33" # fix colors for 777 files
alias -r ls='ls --color=auto'
alias -r l='ls -lah --group-directories-first'
alias -r ll='ls -lh --group-directories-first'

setopt AUTO_PUSHD           # auto push to dir stack
setopt AUTO_CD              # change dir without cd
setopt PUSHD_IGNORE_DUPS    # no duplicates in dir stack
# }}}


# EDITOR {{{
if (( $+commands[nvim] )); then
    export EDITOR=nvim
    export DIFFPROG='nvim -d'
elif (( $+commands[vim] )); then
    export EDITOR=vim
    export DIFFPROG='vim -d'
elif (( $+commands[vi] )); then
    export EDITOR=vi
fi

alias -r v=$EDITOR
alias -r sv=sudoedit
# }}}


# BINDINGS {{{
bindkey -v

# reduce delay when pressing ESC
export KEYTIMEOUT=1

# handle delete key
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char
bindkey "^?" backward-delete-char

# add some of the emacs key bindings to viins mode
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^[." insert-last-word
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^S" history-incremental-search-forward
bindkey -M viins "^U" kill-whole-line
bindkey -M viins "^Y" yank

# up/down for history search
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M viins "^K" up-line-or-beginning-search
bindkey -M viins "^J" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# esc-esc to toogle sudo
_sudo-toggle() {
[[ -z $BUFFER ]] && zle up-history
if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
else
    LBUFFER="sudo $LBUFFER"
fi
}
zle -N _sudo-toggle
bindkey -M emacs '\e\e' _sudo-toggle

# disable flow control (free Ctrl-S, Ctrl-Q)
stty -ixon
# }}}


# HISTORY {{{
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=20000
HISTORY_IGNORE="(ls|l|cd|less) *"

setopt EXTENDED_HISTORY       # record timestamp of command in HISTFILE
setopt SHARE_HISTORY          # share command history data
setopt HIST_IGNORE_ALL_DUPS   # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
setopt HIST_REDUCE_BLANKS     # trim whitespaces before saving to history
#}}}


# COMPLETION {{{
zmodload zsh/complist
autoload -Uz compinit

compinit -d $ZSH/.zcompdump-${ZSH_VERSION}

# use completion menu
zstyle ':completion:*' menu select

# case- and hyphen-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# auto reload completion for new programs
zstyle ':completion:*' rehash true

# Take advantage of $LS_COLORS for completion as well
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

_expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
    print -Pn "%{%F{red}...%f%}"
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam
    zle expand-or-complete
    zle redisplay
}
zle -N _expand-or-complete-with-dots
bindkey "^I" _expand-or-complete-with-dots
# }}}


# PROMPT {{{
autoload -U promptinit; promptinit
PURE_GIT_PULL=0
prompt pure
prompt_newline='%666v'
PROMPT=" $PROMPT"

# change cursor shape based on vi mode
function zle-line-init zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
       [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'

    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = '' ]] ||
         [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
    prompt_pure_update_vim_prompt_widget
    zle reset-prompt
}

# switch back to block cursor
zle-line-finish() {
    echo -ne '\e[2 q'
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish
# }}}


# ALIASES {{{
alias -r sudo='sudo '
alias -r ip='ip -color'
alias -r dd='dd status=progress'
alias -r lb='lsblk -o NAME,SIZE,LABEL,FSTYPE,MOUNTPOINT'
alias -r t='tree -Ca'
# }}}


# FZF {{{
if (( $+commands[fzf] )); then
    source $ZSH/fzf.zsh

    # insert file name with Ctrl-F
    zle -N _fzf-file-widget
    bindkey '^F' _fzf-file-widget

    # history search with Ctrl-R
    zle -N _fzf-history-widget
    bindkey '^R' _fzf-history-widget
fi
# }}}


# SYNTAX
if test -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # highlighting rules
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan,bold'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
fi

# PACMAN
if (( $+commands[pacman] )); then
    usercmd=(Ss Si Sg Sw Qs Qo Ql Qk Qc Qd Qe Qem Qme Qm Qi Qkk Qu Qdt Qtd F Fl)
    sudocmd=(S Syu Rns Sy Syy Syyu U Sc R Fy)

    for c in $usercmd; do; alias $c="pacman -$c"; done
    for c in $sudocmd; do; alias $c="sudo pacman -$c"; done
    export PKGDEST="/var/cache/pacman/pkg/aur"
fi


# RANGER
(( $+commands[ranger] )) && r() {
    local path_file="/tmp/tmp-${RANDOM}"
    ranger --cmd="map s chain shell bash -c \"echo %d > ${path_file}\"; quit" $@
    [ -f $path_file ] && cd "$(cat ${path_file})" && rm ${path_file} || true
}


# lf
(( $+commands[lf] )) && lf() {
    local tmp="$(mktemp)"
    $commands[lf] -last-dir-path "${tmp}" -command="cmd lfcd \${{touch ${tmp}.lfcd}}; map Q :lfcd; quit" $@
    if [[ -f "$tmp" && -f "$tmp".lfcd ]]; then
        local dir="$(< "$tmp")"
        if [[ -d "$dir" ]]; then
            cd "$dir"
        fi
    fi
    rm -f "$tmp" "$tmp".lfcd
}


# source local rc file if it exists
if [ -f $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi
