-- Force Wayland
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("ECORE_EVAS_ENGINE", "wayland_egl")
hl.env("ELM_ENGINE", "wayland_egl")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("_JAVA_AWT_WM_NONEPARENTING", "1")

-- Default vars
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- Libvirt fix
hl.env("LIBVIRT_DEFAULT_URI", "qemu:///system")
