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

      -- Setup ufo with Treesitter + fallback to indent
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Prefer Treesitter, fallback to indent
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
