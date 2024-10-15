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
        },
        json = {
          require("formatter.filetypes.json").jq
        },
        vue = {
          require("formatter.filetypes.vue").prettier
        },
        typescript = {
          require("formatter.filetypes.typescript").prettier
        },
        javascript = {
          require("formatter.filetypes.javascript").prettier
        },
        javascriptreact = {
          require("formatter.filetypes.javascriptreact").prettier
        },
        typescriptreact = {
          require("formatter.filetypes.typescriptreact").prettier
        }
      }
    }
  end
}
