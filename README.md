# Dotfiles

My personal, crossplatform dotfiles, tracked as a bare repository in `$HOME`. This are meant to be platform agnostic (with some caveats). Hence no hyprland config files will be included.

## What's included

The repo includes the following:

- A `bootstrap.sh` script to get setup really quick
- Personal [`gitconfig`](https://git-scm.com/docs/git-config) files with per-organization config (you-shift, masOrange, personal)
- Beautiful terminal integration for git with [lazygit](https://github.com/jesseduffield/lazygit) and [git-split-diffs](https://github.com/banga/git-split-diffs)
- [Wezterm](https://wezterm.org/) configuration files with built in status bar, workspaces persistance and smart session management
- My [Neovim](https://neovim.io/) config for version `v0.12.0`
- [Alacritty](https://alacritty.org/) config for quick terminal spawns (nothing beats alacritty's speed)
- My personal [zsh](https://www.zsh.org/) config
- TUI enhancers like [`starship.toml`](https://starship.rs/) and [`bat`](https://github.com/sharkdp/bat)

## How it works

Instead of symlinking files from a separate repo, this uses a **bare Git repository** at `~/.dotfiles` with `$HOME` as its work tree. Files live where they normally would (`~/.gitconfig`, `~/.config/lazygit/config.yml`, etc.), and a shell alias — `dotfiles` — wraps `git` with the right `--git-dir` and `--work-tree` flags so you can version-control them in place.

No symlinks, no extra tooling.

## Installing on a new machine

### Quick way (bootstrap script)

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/bootstrap.sh | bash
```

The script clones the repo as bare into `~/.dotfiles`, backs up any conflicting files to `~/.dotfiles-backup/`, checks out everything into `$HOME`, and runs all one-time setup (see [What the bootstrap does](#what-the-bootstrap-does) below).

After it finishes, add the alias to your shell rc file (`~/.zshrc`, `~/.bashrc`, etc.) and reload:

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

### Manual way

If you'd rather do it by hand, clone as bare:

```bash
git clone --bare git@github.com:YOUR_USERNAME/dotfiles.git $HOME/.dotfiles
```

Add the alias to your shell rc file and reload:

```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Try to check out the files into `$HOME`:

```bash
dotfiles checkout
```

If checkout complains about files that already exist (like an existing `.gitconfig` or `.zshrc`), back them up and retry:

```bash
mkdir -p $HOME/.dotfiles-backup
dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | \
  xargs -I{} sh -c 'mkdir -p "$HOME/.dotfiles-backup/$(dirname {})" && mv "$HOME/{}" "$HOME/.dotfiles-backup/{}"'
dotfiles checkout
```

Then tell the repo not to show every untracked file in `$HOME`:

```bash
dotfiles config --local status.showUntrackedFiles no
```

## What the bootstrap does

The `bootstrap.sh` script handles one-time setup that can't be tracked in the repo itself:

- Clones the bare repo to `~/.dotfiles`
- Backs up conflicting files to `~/.dotfiles-backup/` before checkout
- Sets `status.showUntrackedFiles no` on the local repo config
- Configures `git-split-diffs` with the correct absolute theme path for this machine (since `~` doesn't expand inside that tool's config)
- Clones `zsh-autosuggestions` and `zsh-syntax-highlighting` into `~/.oh-my-zsh/custom/plugins/`
- Symlinks the right Alacritty platform config for the current OS

Re-running it is safe — each step checks whether the work is already done.

## External tools to install separately

This repo tracks **configs**, not binaries. Install the tools themselves via your package manager:

- **lazygit** — `brew install lazygit` (macOS) or `pacman -S lazygit` (Arch)
- **git-split-diffs** — `npm install -g git-split-diffs`
- **oh-my-zsh** — see [installation instructions](https://ohmyz.sh/#install)

## Daily usage

Use `dotfiles` wherever you'd normally use `git`:

```bash
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m "Update alacritty config"
dotfiles push
```

To start tracking a new file:

```bash
dotfiles add .config/some-tool/config.yml
dotfiles commit -m "Add some-tool config"
dotfiles push
```

## Setting it up from scratch

For reference, here's how the repo was originally created:

```bash
git init --bare $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no

dotfiles add .gitconfig
dotfiles add .config/lazygit/config.yml
dotfiles commit -m "Initial commit"

dotfiles remote add origin git@github.com:YOUR_USERNAME/dotfiles.git
dotfiles branch -M main
dotfiles push -u origin main
```

## Notes

- Only **one** bare repo in `$HOME` should be configured with `--work-tree=$HOME`. Other bare repos in your home directory (e.g. project remotes) are fine — they just shouldn't share this work tree.
- `status.showUntrackedFiles no` is what makes `dotfiles status` usable. Without it, every file in `$HOME` shows up as untracked.
- Credit to the [original Hacker News post](https://news.ycombinator.com/item?id=11070797) that popularized this technique.
