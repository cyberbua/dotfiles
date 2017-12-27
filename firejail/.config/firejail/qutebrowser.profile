# Firejail profile for qutebrowser

# noblacklist
noblacklist ~/.cache/qutebrowser
noblacklist ~/.config/qutebrowser

# blacklist
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-programs.inc

# whitelist
mkdir ~/.cache/qutebrowser
mkdir ~/.config/qutebrowser
mkdir ~/.local/share/qutebrowser
whitelist ${DOWNLOADS}
whitelist ~/.cache/qutebrowser
whitelist ~/.config/qutebrowser
whitelist ~/.config/qutebrowser/config.py
whitelist ~/.local/share/qutebrowser
include /etc/firejail/whitelist-common.inc

# # whitelist term & editor config
# whitelist ~/.config/nvim
# whitelist ~/.config/termite
# whitelist ~/dotfiles
# whitelist ~/.vim
# read-only ~/.config/nvim
# read-only ~/.config/termite
# read-only ~/.dotfiles
# read-only ~/.vim

# config
ipc-namespace
caps.drop all
netfilter
nodvd
nonewprivs
noroot
notv
protocol unix,inet,inet6,netlink
seccomp
tracelog
private-tmp
# noexec ${HOME}
noexec /tmp
