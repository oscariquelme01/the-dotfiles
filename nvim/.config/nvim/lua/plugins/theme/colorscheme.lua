return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      custom_highlights = function(colors)
        return {
          TabLineSel = { bg = colors.green },
          NvimTreeWinSeparator = { fg = colors.crust },
          VertSplit = { fg = colors.crust },

          -- Treesitter stuff
          ['@variable.member'] = { fg = colors.yellow },
          ['@property'] = { fg = colors.yellow },
          ['@module'] = { fg = colors.yellow },
          ['@variable.parameter'] = { fg = colors.red },

          -- Telescope stuff
          TelescopeBorder = { fg = colors.base },
          TelescopePreviewTitle = { fg = colors.yellow },
          TelescopePromptTitle = { fg = colors.yellow },
          TelescopeResultsTitle = { fg = colors.yellow },
          TelescopePromptNormal = { bg = colors.surface0 },
          TelescopePromptPrefix = { bg = colors.surface0 },
          TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },
          TelescopeSelectionCaret = { fg = colors.yellow },
        }
      end,
      color_overrides = {
        all = {
          base = '#161616',
          mantle = '#161616',
          crust = '#0C0C0C',
          text = '#FFFFFF',
          surface0 = '#3D3D3D',
          surface1 = '#666666',
          surface2 = '#B8B8B8',
        },
      },
    }
    vim.o.termguicolors = true -- Use terminal gui colors
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
