# Firejail profile for qutebrowser

# noblacklist
noblacklist ~/.cache/qutebrowser
noblacklist ~/.config/qutebrowser
noblacklist ~/.local/share/qutebrowser

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

caps.drop all
netfilter
nodvd
nonewprivs
noroot
notv
protocol unix,inet,inet6,netlink
# blacklisting of chroot system calls breaks qt webengine
seccomp.drop @clock,@cpu-emulation,@debug,@module,@obsolete,@raw-io,@reboot,@resources,@swap,acct,add_key,bpf,fanotify_init,io_cancel,io_destroy,io_getevents,io_setup,io_submit,ioprio_set,kcmp,keyctl,mount,name_to_handle_at,nfsservctl,ni_syscall,open_by_handle_at,personality,pivot_root,process_vm_readv,ptrace,remap_file_pages,request_key,setdomainname,sethostname,syslog,umount,umount2,userfaultfd,vhangup,vmsplice
# tracelog
