# Chromium browser profile

# noblacklist
noblacklist ~/.config/chromium
noblacklist ~/.cache/chromium
noblacklist ~/.pki

# blacklist
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-passwdmgr.inc

# whitelist
include /etc/firejail/whitelist-common.inc
whitelist ${DOWNLOADS}
whitelist ~/.config/chromium
whitelist ~/.cache/chromium
whitelist ~/.config/chromium-flags.conf
whitelist ~/.pki
mkdir ~/.config/chromium
mkdir ~/.cache/chromium
mkdir ~/.pki

# config
# caps.keep sys_chroot,sys_admin
ipc-namespace
netfilter
nogroups
# noroot
shell none
private-dev
private-tmp
noexec ${HOME}
noexec /tmp
