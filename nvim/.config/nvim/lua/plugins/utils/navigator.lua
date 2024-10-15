local keymap = vim.api.nvim_set_keymap

return {
  "numToStr/navigator.nvim",
  lazy = false,
  cmd = { "NavigatorLeft", "NavigatorRight", "NavigatorUp", "NavigatorDown" },
  config = function()
    require("Navigator").setup({ disable_on_zoom = true })

    keymap("n", "<C-h>", "<cmd>NavigatorLeft<CR>", { noremap = true, silent = true })
    keymap("n", "<C-j>", "<cmd>NavigatorDown<CR>", { noremap = true, silent = true })
    keymap("n", "<C-k>", "<cmd>NavigatorUp<CR>", { noremap = true, silent = true })
    keymap("n", "<C-l>", "<cmd>NavigatorRight<CR>", { noremap = true, silent = true })
  end,
}
