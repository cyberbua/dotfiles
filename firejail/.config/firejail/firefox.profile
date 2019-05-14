# Firejail profile for Mozilla Firefox (Iceweasel in Debian)

# noblacklist
noblacklist ~/.mozilla
noblacklist ~/.cache/mozilla
noblacklist ~/.pki

# blacklist
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc

# whitelist
include /etc/firejail/whitelist-common.inc
whitelist ${DOWNLOADS}
whitelist ~/.mozilla
whitelist ~/.cache/mozilla/firefox
whitelist ~/.pki
mkdir ~/.mozilla
mkdir ~/.cache/mozilla/firefox
mkdir ~/.pki

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
# tracelog
# x11 xorg
private-dev
private-tmp
noexec ${HOME}
noexec /tmp
