#!/usr/bin/env bash
set -euo pipefail

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.dotfiles"

if [ "$SCRIPT_DIR" != "$TARGET_DIR" ]; then
	echo "SCRIPT_DIR ($SCRIPT_DIR) is not the expected directory ($TARGET_DIR). Exiting..."
	exit 1
fi

# Function to prompt for yes/no (default: yes)
prompt_yes_no() {
	local prompt="$1"
	local default="${2:-Y}"
	local approval

	# Normalize default to y/n
	[[ "$default" =~ [Yy] ]] && local default_char="Y" || local default_char="N"

	while true; do
		# Show prompt with [Y/n] or [y/N] depending on default
		if [[ "$default_char" == "Y" ]]; then
			read -r -p "$prompt [Y/n] " approval
			approval="${approval:-Y}"
		else
			read -r -p "$prompt [y/N] " approval
			approval="${approval:-N}"
		fi

		case "$approval" in
			[Yy]|[Yy][Ee][Ss])
				return 0
				;;
			[Nn]|[Nn][Oo])
				return 1
				;;
			*)
				echo "Please answer yes or no."
				;;
		esac
	done
}

# Zshrc home path
HOME_ZSHRC="$HOME/.zshrc"

# Source config directory
CONFIG_SRC="$SCRIPT_DIR/config"

# Symlink .zshrc
ZSHRC="$SCRIPT_DIR/zsh/.zshrc"

if [ -e "$ZSHRC" ]; then
	if [ -e "$HOME_ZSHRC" ] || [ -L "$HOME_ZSHRC" ]; then
		if prompt_yes_no "A .zshrc already exists at $HOME_ZSHRC. Overwrite?"; then
			rm -rf "$HOME_ZSHRC"
			ln -s "$ZSHRC" "$HOME_ZSHRC"
		else
			echo "Skipping .zshrc symlink."
		fi
	else
		ln -s "$ZSHRC" "$HOME_ZSHRC"
	fi
else
	echo "No .zshrc found at $(dirname "$ZSHRC"). Skipping."
fi


# Symlink contents of config/ into home
if [ -d "$CONFIG_SRC" ]; then
	echo "Symlinking contents of $CONFIG_SRC into $HOME"

	for item in "$CONFIG_SRC"/*; do
		[ -e "$item" ] || continue
		base="$(basename "$item")"
		target="$HOME/.config/$base"

	# If target exists, remove it (file, dir, or symlink)
	if [ -e "$target" ] || [ -L "$target" ]; then
		if prompt_yes_no "$target already exists. Overwrite?"; then
			rm -rf "$target"
		else
			echo "Skipping $target"
			continue
		fi
	fi

	ln -s "$item" "$target"
done
else
	echo "Config directory not found at $CONFIG_SRC. Nothing to symlink."
fi

echo "Bootstrap complete."
