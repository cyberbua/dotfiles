# My Setup

- **OS:** Arch Linux
- **Window Manager/Compositor:** sway
- **Bar:** swaybar + i3status-rs
- **Terminal:** [termite](https://github.com/thestinger/termite)
- **Shell:** Zsh
    - bits and pieces of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and others
- Theme and fonts
    - **GTK Theme:** Arc Darker
    - **icon theme:** Ultra Flat
    - **font:** Roboto Mono
- **Editor:** Neovim
- **Firefox**
    - [Arc Darker Theme](https://github.com/horst3180/arc-firefox-theme)
    - Add-ons
        - uBlock Origin

## HowTo
All the config files in this repo are managed by [GNU stow](https://www.gnu.org/software/stow/), so I'd recommend installing it if you want to easily apply and update my configs. By default the stow command will create symlinks for files in the parent directory of where you execute the command. So my dotfiles setup assumes this repo is located in the root of your home directory ~/dotfiles. And all stow commands should be executed in that directory.

```bash
# navigate to your home directory:
cd ~

# clone this repository:
git clone https://github.com/hmohamad/dotfiles

# enter the directory:
cd dotfiles

# install zsh and tmux configs:
stow zsh tmux

# uninstall tmux configs:
stow -D tmux
```
