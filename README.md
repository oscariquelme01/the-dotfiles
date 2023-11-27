# The glorious dotfiles repo

## TLDR

This repo is intended to keep track of the different configs for most of the programs I use. This include the following:

- Neovim
- Awesome WM
- Alacritty
- Wezterm
- Zsh
- Obsidian
- Starship

Each of the programs listed above will have its corresponding README.md inside the folder explaining most of the config and functionality

Each commit message starting from `0d6236e` needs to follow the following structure:

[PROGRAM AFFECTED] Type of commit: change made

Examples:

```
[NVIM] feat: git telescope integration & mappings
[AWESOME] wip: add empty files for alt tab
```

## Instalation

Just run the script and hope for the best. The script is yet to be improved and tested, but at least it makes sure to create backups of your dotfiles :)
```bash
git clone https://github.com/oscariquelme01/the-dotfiles.git ~/Dotfiles
chmod +x install.sh && ./install.sh
```
