-- Lazy
return {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local home = vim.fn.expand('$HOME')

      require("chatgpt").setup({
      api_key_cmd = "cat " .. home .. "/chatGPTAPI.key",
      openai_params = {
        model = "gpt-4-1106-preview"
      }
    })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
}
