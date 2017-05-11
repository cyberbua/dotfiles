# My Setup

- **OS:** Arch Linux x86_64
- **Window Manager:** i3wm
- **Bar:** [polybar](https://github.com/jaagr/polybar)
- **Terminal:** [termite](https://github.com/thestinger/termite)
- **Shell:** Zsh
    - bits and pieces of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- Theme and fonts
    - **GTK Theme:** Arc Darker
    - **icon theme:** Ultra Flat
    - **fonts:** Roboto & [Roboto Mono Nerdfont](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/RobotoMono/complete)
- **Editor:** Neovim
- **Firefox**
    - [Arc Darker Theme](https://github.com/horst3180/arc-firefox-theme)
    - Add-ons
        - uMatrix
        - Tab Groups
        - SSleuth

## HowTo
All the config files in this repo are managed by [GNU stow](https://www.gnu.org/software/stow/), so I'd recommend installing it if you want to easily apply und update my configs. By default the stow command will create symlinks for files in the parent directory of where you execute the command. So my dotfiles setup assumes this repo is located in the root of your home directory ~/dotfiles. And all stow commands should be executed in that directory.

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

## Config Locations
```
├── .config
│   ├── bspwm/bspwmrc        # bspwm config (window manager config)
│   ├── sxhkd/sxhkdrc        # sxhkd config (keyboard bindings)
│   ├── polybar/             # bar config and scripts
│   ├── termite/config       # terminal emulator config
│   ├── Thunar/uca.xml       # thunar custom actions
│   ├── rofi/config          # application launcher settings
│   ├── htop/htoprc          # htop settings
│   ├── compton.conf         # compositor config (for them nice shadows)
│   └── chromium-flags.conf  # chromium flags (use ram as cache etc.)
├── .local
│   └── share
│       ├── fonts/           # drop fonts here
│       └── icons/           # drop icon themes here 
├── scripts
│   └── blurlock             # lockscreen script
├── .themes/                 # drop GTK themes here
├── .oh-my-zsh               # zsh config and plugins
├── .vim
│   └── autoload/plug.vim    # plugin manager itself
├── .tmux.conf
├── .vimrc
├── .xinitrc
└── .zshrc
```
