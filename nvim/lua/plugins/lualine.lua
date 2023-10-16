return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'kdheepak/tabline.nvim'
  },
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'ayu_dark',
      component_separators = '|',
      section_separators = '',
    }
  },
}
