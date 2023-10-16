# The glorious dotfiles repo

## TLDR

This repo is intended to keep track of the different configs for most of the programs I use. This include the following:

- Neovim
- Awesome WM
- Alacritty
- Wezterm
- Zsh

Each of the programs listed above will have its corresponding README.md inside the folder explaining most of the config 

Each commit message needs to follow the following structure:

[PROGRAM AFFECTED] Type of commit: change made

Examples:

```
[NVIM] feat: git telescope integration & mappings
[AWESOME] wip: add empty files for alt tab
```

## Instalation
```bash
git clone https://github.com/oscariquelme01/the-dotfiles.git ~/Dotfiles && ./install.sh 
```

> Note: The install.sh will install all the programs using arch linux's package manager (pacman) so it won't work for any non-arch based distros. However, you can make the symlinks manually or using the following script:

> :warning: **This will override any existing dotfiles for any of the programs listed above!!**

```bash
ln -sf ~/Dotfiles/nvim ~/.config/nvim
ln -sf ~/Dotfiles/awesome ~/.config/awesome
ln -sf ~/Dotfiles/zsh ~/.config/zsh
ln -sf ~/Dotfiles/wezterm ~/.config/wezterm
ln -sf ~/Dotfiles/alacritty ~/.config/alacritty
ln -sf ~/Dotfiles/obsidian ~/.config/obsidian
```
