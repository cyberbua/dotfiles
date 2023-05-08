__fzfcmd() {
    fzf --reverse --height 40% --min-height=14 $@
}

_fzf-file-widget() {
  local base=${${LBUFFER##* }:h}
  local sel=$(find ${base} 2> /dev/null | __fzfcmd --query=${${LBUFFER##* }:t} --scheme=path)
  LBUFFER="${LBUFFER% *} ${sel}"
  local ret=$?
  zle reset-prompt
  return $ret
}

_fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=($(fc -rl 1 | __fzfcmd --query=${LBUFFER} --no-multi --scheme=history))
    local ret=$?
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n $num
        fi
    fi
    zle reset-prompt
    return $ret
}
