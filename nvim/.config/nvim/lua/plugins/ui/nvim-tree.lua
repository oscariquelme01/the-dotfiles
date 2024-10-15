local keymap = vim.api.nvim_set_keymap

local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd(
  "VimEnter", {
    callback = function()
      -- cd into the directory given as an argument
      vim.cmd "if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |  wincmd p | enew | execute 'cd '.argv()[0] | endif "

      -- toggle nvim tree if given argument is a directory
      vim.cmd "if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute ':NvimTreeToggle' | endif"
    end
  })

return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  cmd = { "NvimTreeToggle" },
  config = function()
    require("nvim-tree").setup(options)
  end,
  init = function()
    keymap("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
  end
}
