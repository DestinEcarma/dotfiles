# Configuration Files

This directory contains my personal application and desktop configuration files. The setup is a work in progress and may change as my workflow evolves.

## Prerequisites

Install the applications below for their corresponding configuration files to work correctly.

- [`alacritty`](https://github.com/alacritty/alacritty)
- [`fastfetch`](https://github.com/fastfetch-cli/fastfetch)
- [`ghostty`](https://github.com/ghostty-org/ghostty)
- [`kitty`](https://github.com/kovidgoyal/kitty)
- [`matugen`](https://github.com/InioX/matugen)
- [`neovim`](https://github.com/neovim/neovim)
    - Run `:checkhealth` in Neovim to identify any missing dependencies.
- [`rofi`](https://github.com/davatorium/rofi)
    - [`rofi-calc`](https://github.com/svenstaro/rofi-calc)
- [`swaync`](https://github.com/ErikReider/SwayNotificationCenter)
- [`swayosd`](https://github.com/ErikReider/SwayOSD)
- [`tmux`](https://github.com/tmux/tmux)
- [`waybar`](https://github.com/Alexays/Waybar)
    - [`wlctl`](https://github.com/aashish-thapa/wlctl)
    - [`bluetui`](https://github.com/pythops/impala)
    - [`wiremix`](https://github.com/tsowell/wiremix)
- [`wlogout`](https://github.com/ArtsyMacaw/wlogout)

### Hyprland

The [`Hyprland`](https://github.com/hyprwm/Hyprland) configuration also expects the following tools:

- [`nautilus`](https://github.com/GNOME/nautilus) — launched with `SUPER + E`; replace it with any file manager you prefer.
- [`gnome-polkit`](https://gitlab.gnome.org/Archive/policykit-gnome) — replaceable with another Polkit authentication agent.
- [`hyprshot`](https://github.com/Gustash/Hyprshot) — screenshot utility.
- [`awww`](https://codeberg.org/LGFae/awww) — wallpaper daemon.
- [`paper-tui`](https://github.com/DestinEcarma/paper-tui) — wallpaper manager.

> **Note:** Kitty is configured as Hyprland's default terminal emulator. Update the Hyprland configuration if you prefer another terminal.

## Recommended System Packages

These packages are recommended for a functional Hyprland desktop environment:

- `pipewire` — audio support.
- `bluez` — Bluetooth support.
- `networkmanager` — network management.
- `xdg-desktop-portal-hyprland` — desktop portal support for Hyprland.
- `xdg-desktop-portal-gtk` — portal support for GTK applications.
- `nwg-look` — GTK theme and icon configuration.
- `sddm` — display manager; you may use an alternative.

## Services

Some packages require their system services to be enabled manually. For example:

```sh
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sddm
```

Enable only the services that apply to your system.
