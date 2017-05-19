# Firejail profile for Mozilla Firefox (Iceweasel in Debian)

# noblacklist
noblacklist ~/.jd

# blacklist
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc

# whitelist
include /etc/firejail/whitelist-common.inc
whitelist ${DOWNLOADS}
whitelist ~/.jd
mkdir ~/.jd

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
private-tmp
noexec /tmp
