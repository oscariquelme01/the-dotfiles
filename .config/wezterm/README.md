# WezTerm Config

Cross-platform WezTerm configuration that works on both macOS and Linux.

## Structure

```
wezterm.lua              -- Entry point, loads all modules
keybindings.lua          -- Core keybindings
theme.lua                -- Vesper theme, GeistMono Nerd Font, window styling
utils.lua                -- Shared helpers (platform-aware modifier key, add_keys)
plugins/
  bar.lua                -- Status bar (tabs, workspace indicator, copy mode)
  navigator.lua          -- Seamless pane navigation between WezTerm and Neovim
  resurrect.lua          -- Workspace/tab/window state persistence and restore
  smart_workspace_switcher.lua -- Fuzzy workspace switcher
```

## Cross-Platform Modifier Key

`utils.mod` resolves to `CMD` on macOS and `CTRL` on Linux. This keeps keybindings ergonomic on both platforms — `CMD` is used for app shortcuts on macOS, while on Linux `CTRL` serves the same role and `SUPER` stays free for window manager bindings (e.g. Hyprland workspaces).

All keybindings reference `utils.mod` instead of hardcoding a modifier.

## Keybindings

`mod` = `CMD` (macOS) / `CTRL` (Linux)

| Keys | Action |
|------|--------|
| `mod+ALT+v` | Split pane vertically |
| `mod+ALT+x` | Split pane horizontally |
| `mod+ALT+w` | Create new workspace |
| `mod+ALT+t` | Rename tab |
| `mod+p` | Paste from clipboard |
| `mod+c` | Enter copy mode |
| `mod+z` | Quick select mode |
| `mod+r` | Forward `Ctrl+r` (redo in Neovim) |
| `mod+s` | Fuzzy switch workspace |
| `mod+SHIFT+s` | Save workspace state |
| `mod+SHIFT+r` | Restore workspace/tab/window from fuzzy loader |
| `mod+SHIFT+d` | Delete saved state |

### Pane Navigation (Navigator)

| Keys | Action |
|------|--------|
| `mod+h` | Navigate left |
| `mod+j` | Navigate down |
| `mod+k` | Navigate up |
| `mod+l` | Navigate right |

These work seamlessly across WezTerm panes and Neovim splits using [Navigator.nvim](https://github.com/numToStr/Navigator.nvim). When the active pane is running Neovim, the keypress is forwarded as `CTRL+h/j/k/l` so Navigator.nvim can handle it. Otherwise, WezTerm navigates directly.

## Plugins

- [bar.wezterm](https://github.com/adriankarlen/bar.wezterm) -- Status bar with tab and workspace info
- [resurrect.wezterm](https://github.com/MLFlexer/resurrect.wezterm) -- Persist and restore workspace state (auto-saves periodically and on workspace switch)
- [smart_workspace_switcher.wezterm](https://github.com/MLFlexer/smart_workspace_switcher.wezterm) -- Fuzzy workspace picker with resurrect integration

## Theme

- Color scheme: [Vesper](https://github.com/raunofreiberg/vesper)
- Font: GeistMono Nerd Font (14pt)
- No title bar, resizable window
- Inactive panes dimmed to 70% brightness
