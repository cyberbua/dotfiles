# Firejail profile for Mozilla Firefox (Iceweasel in Debian)

# noblacklist
noblacklist ~/.local/share/TelegramDesktop

# blacklist
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc
blacklist ~/.local/share/applications/telegramdesktop.desktop

# config
caps.drop all
ipc-namespace
netfilter
nogroups
nonewprivs
noroot
protocol unix,inet,inet6,netlink
seccomp
shell none
tracelog
# x11 xorg
private-dev
# private-tmp
noexec ${HOME}
noexec /tmp
