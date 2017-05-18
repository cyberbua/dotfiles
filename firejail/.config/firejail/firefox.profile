# Firejail profile for Mozilla Firefox (Iceweasel in Debian)
noblacklist ~/.mozilla
noblacklist ~/.cache/mozilla
noblacklist ~/.pki
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc

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

whitelist ${DOWNLOADS}
mkdir ~/.mozilla
whitelist ~/.mozilla
mkdir ~/.cache/mozilla/firefox
whitelist ~/.cache/mozilla/firefox
whitelist ~/dwhelper
whitelist ~/.zotero
whitelist ~/.vimperatorrc
whitelist ~/.vimperator
whitelist ~/.pentadactylrc
whitelist ~/.pentadactyl
whitelist ~/.keysnail.js
mkdir ~/.pki
whitelist ~/.pki


include /etc/firejail/whitelist-common.inc

# experimental features
#private-bin firefox,which,sh,dbus-launch,dbus-send,env
#private-etc passwd,group,hostname,hosts,localtime,nsswitch.conf,resolv.conf,xdg,gtk-2.0,gtk-3.0,X11,pango,fonts,firefox,mime.types,mailcap,asound.conf,pulse
private-dev
private-tmp

noexec ${HOME}
noexec /tmp
