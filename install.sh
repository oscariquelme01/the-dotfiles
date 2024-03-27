#!/bin/bash

echo "Need to install all the programs??"
read -r needInstall

if [ "$needInstall" = "y" ] || [ "$needInstall" = "Y" ]; then
	sudo pacman -S neovim awesome zsh wezterm alacritty obsidian
fi

paths=("nvim" "awesome" "zsh" "wezterm" "alacritty" "obsidian/.obsidian.vimrc" "starship.toml" "lf")

for path in "${paths[@]}"; do
	mv "$HOME/.config/${path}" "$HOME/.config/${path}.backup"
	ln -sf "$HOME/Dotfiles/$path" "$HOME/.config/${path}"
done
