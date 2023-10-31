return {
  'mhartington/formatter.nvim',
  lazy = false,
  config = function()

    require('formatter').setup {
      filetype = {
        python = {
          require("formatter.filetypes.python").black,
        },
        lua = {
          require("formatter.filetypes.lua").stylua
        }
      }
    }
  end
}
