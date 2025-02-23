return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = 'BufReadPost',
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.keymap.set('n', 'zr', require('ufo').openAllFolds, { desc = 'open all folds' })
    vim.keymap.set('n', 'zm', require('ufo').closeAllFolds, { desc = 'close all folds' })
    vim.keymap.set('n', 'zp', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
    end, { desc = 'peak into fold or hover'})

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
  end,
}
