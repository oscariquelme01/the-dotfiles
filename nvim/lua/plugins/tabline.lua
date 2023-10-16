return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies ={
    {
      'tiagovla/scope.nvim',
      config = function ()
        require("scope").setup({})
      end
    },
    'nvim-tree/nvim-web-devicons',
  },
  config = function ()
    require("bufferline").setup{
      options = {
      }
    }
  end
}
