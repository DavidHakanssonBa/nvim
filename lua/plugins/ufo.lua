return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
      -- Set fold options
      vim.o.foldcolumn = "1"       -- Show fold column
      vim.o.foldlevel = 99         -- Start with all folds open
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true      -- Enable folding

      local km = vim.keymap.set
      km("n", "zF", function() require("ufo").closeAllFolds() end, { desc = "UFO: Close all folds" })
      km("n", "zO", function() require("ufo").openAllFolds() end, { desc = "UFO: Open all folds" })
      km("n", "zC", function() require("ufo").closeFoldsWithCursor() end, { desc = "UFO: Close folds under cursor" })
      km("n", "zP", function() require("ufo").peekFoldedLinesUnderCursor() end, { desc = "UFO: Preview fold content" })
      km("n", "zH", function() vim.o.foldcolumn = vim.o.foldcolumn == "0" and "1" or "0" end, { desc = "UFO: Toggle fold column" })

      -- Setup ufo with Treesitter + fallback to indent
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
