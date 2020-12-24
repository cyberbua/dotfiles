# autostart sway on tty1
if [[ "$(tty)" == '/dev/tty1' ]]; then
    export PATH="$HOME/bin:$PATH"
    export QT_QPA_PLATFORMTHEME=gtk2
    export MOZ_ENABLE_WAYLAND=1
    export CLUTTER_BACKEND=wayland
    export QT_QPA_PLATFORM=wayland-egl
    export GTK_THEME=Arc-Darker
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway

    exec sway -d &> /tmp/sway.log
fi
