return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      "princejoogie/dir-telescope.nvim",
      config = function()
        require("telescope").load_extension("dir")
      end,
      lazy = true,
      cmd = { "Telescope dir live_grep", "Telescope dir find_files" },
    },
  },
  config = function()
    local keymap = vim.keymap.set

    keymap('n', '<leader>fv', require('telescope.builtin').git_status, { desc = 'Search modified files' })
    keymap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search files' })
    keymap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search help' })
    keymap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Search by grep' })
    keymap('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics' })
    keymap('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'Search resume' })
    keymap('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
    keymap('n', '<leader>dff', '<cmd>Telescope dir find_files<CR>', { desc = 'Find files in dir' })
    keymap('n', '<leader>dfg', '<cmd>Telescope dir live_grep<CR>', { desc = 'Live grep in dir' })
    keymap('n', '<leader><space>', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
        sorting_strategy = 'ascending'
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    require('telescope').setup {
      defaults = {
        layout_strategy = 'flex',
        layout_config = { prompt_position = 'top' },
        file_ignore_patterns = { "node_modules" },
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true
        }
      }
    }
  end
}
