return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, {})

    require('ufo').setup()
  end
}
