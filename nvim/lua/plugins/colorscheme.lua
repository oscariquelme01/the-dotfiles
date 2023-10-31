return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('nightfox').setup({
      specs = {
        carbonfox = {
          diag_bg = {
            error = '#000000',
          }
        }
      }
    })
    vim.cmd [[colorscheme carbonfox]]
  end,
}
