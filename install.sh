#!/bin/bash

echo "Need to install all the programs??"
read -r needInstall

if [ "$needInstall" = "y" ] || [ "$needInstall" = "Y" ]; then
	sudo pacman -S neovim awesome zsh wezterm alacritty obsidian
fi

echo "Warning! This will overwrite any existing dotfiles from neovim, awesome, zsh, wezterm, alacritty and some of the obsidian. Press enter to continue or press CTRL-C to cancel"
read -r
ln -sf ~/Dotfiles/nvim ~/.config/nvim
ln -sf ~/Dotfiles/awesome ~/.config/awesome
ln -sf ~/Dotfiles/zsh ~/.config/zsh
ln -sf ~/Dotfiles/wezterm ~/.config/wezterm
ln -sf ~/Dotfiles/alacritty ~/.config/alacritty
ln -sf ~/Dotfiles/obsidian/.obsidian.vimrc ~/.config/.obsidian.vimrc
