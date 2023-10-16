#!/bin/bash

sudo pacman -S nvim awesome zsh wezterm alacritty obsidian

ln -sf ~/Dotfiles/nvim ~/.config/nvim
ln -sf ~/Dotfiles/awesome ~/.config/awesome
ln -sf ~/Dotfiles/zsh ~/.config/zsh
ln -sf ~/Dotfiles/wezterm ~/.config/wezterm
ln -sf ~/Dotfiles/alacritty ~/.config/alacritty
ln -sf ~/Dotfiles/obsidian/.obsidian.vimrc ~/.config/.obsidian.vimrc
