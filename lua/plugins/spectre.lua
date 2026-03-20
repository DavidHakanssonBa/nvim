return {
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Required dependency
    config = function()
      local spectre = require('spectre')
      spectre.setup()

      -- Keymaps
      vim.keymap.set('n', '<leader>sr', function()
        spectre.open()
      end, { desc = 'Search and Replace in Project' })

      vim.keymap.set('n', '<leader>sw', function()
        spectre.open_visual({ select_word = true })
      end, { desc = 'Search current word' })

      vim.keymap.set('v', '<leader>sw', function()
        spectre.open_visual()
      end, { desc = 'Search selected text' })

      vim.keymap.set('n', '<leader>sp', function()
        spectre.open_file_search({ select_word = true })
      end, { desc = 'Search in current file' })
    end
  }
}
