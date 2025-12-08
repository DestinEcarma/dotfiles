# Config

On this directory, contains all of the configuration files. This is a collection of my personal configuration files for my system. This is a work in progress and will be updated as I go along.

## Prerequisites

This section are a prerequisite tools for each configuration file.

- [`fastfetch`](https://github.com/fastfetch-cli/fastfetch)
- [`hypr`](https://github.com/hyprwm/Hyprland)
    - [`nautilus`](https://github.com/GNOME/nautilus) - This is what is set on the **key bindings** for `MOD + E`. You can use any file manager that you prefer.
    - [`gnome-polkit`](https://gitlab.gnome.org/Archive/policykit-gnome) - You can use any polkit agent that you prefer.
    - [`hyprpaper`](https://github.com/hyprwm/hyprpaper) - This will serve as the wallpaper utility.
    - [`hyprshot`](https://github.com/Gustash/Hyprshot) - This will serve as the screenshot utility.
    - [`swww`](https://github.com/LGFae/swww)
- [`kitty`](https://github.com/kovidgoyal/kitty) - `hyprland` uses `kitty` as the default terminal emulator. You can change this to your preferred terminal emulator. This is just my personal config.
- [`ghostty`](https://github.com/ghostty-org/ghostty)
- [`nvim`](https://github.com/neovim/neovim)
    - [`fd`](https://github.com/sharkdp/fd)
    - [`ripgrep`](https://github.com/BurntSushi/ripgrep)
    - Please run the `checkhealth` command on `neovim` to check for more information for missing dependencies.
- [`rofi`](https://github.com/davatorium/rofi)
    - [`rofi-calc`](https://github.com/svenstaro/rofi-calc)
- [`wal`](https://github.com/dylanaraps/pywal)
- [`waybar`](https://github.com/dylanaraps/pywal)
    - [`impala`](https://github.com/pythops/impala)
    - [`bluetui`](https://github.com/pythops/impala)
    - [`wiremix`](https://github.com/tsowell/wiremix)
- [`wlogout`](https://github.com/ArtsyMacaw/wlogout) - This is is used by `waybar`.
- [`tmux`](https://github.com/tmux/tmux)

## Recommended

This section are the recommended tools to have, currently I am using `hyprland` as my window manager. Installing `hyprland` on a minimal installation of `arch` can be a bit tricky and time consuming. So this will be the list of tools that I used to work with `hyprland`.

- `pipewire` - This is for audio support.
- `bluez` - This is for bluetooth support.
- `networkmanager` - This is for network support.
- `xdg-desktop-portal-hyprland`
- `xdg-desktop-portal-gtk` - Since I use a lot of `gtk` applications, I need to have this installed.
- `nwg-look` - This is for managing the themes and icons for `gtk` applications.
- `sddm` - This is for the display manager. You can use any display manager that you prefer.

Some of this tools are still needed to be manually start on `systemctl` or enable on startup.
