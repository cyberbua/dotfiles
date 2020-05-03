# autostart sway on tty1
if [[ "$(tty)" == '/dev/tty1' ]]; then
    export PATH="$HOME/bin:$PATH"
    export QT_QPA_PLATFORMTHEME=gtk2
    export GDK_BACKEND=wayland
    export CLUTTER_BACKEND=wayland
    export QT_QPA_PLATFORM=wayland-egl
    export GTK_THEME=Arc-Darker
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

    exec sway -d &> /tmp/sway.log
fi
