return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages you want parsers for
        ensure_installed = {
          "bash",
          "lua",
          "vim",
          "vimdoc",
          "python",
          "javascript",
          "html",
          "css",
          "json",
          "yaml",
        },

        -- Highlighting
        highlight = {
          enable = true,
          disable = { "json" },
          additional_vim_regex_highlighting = false,
        },

        -- Indentation (some languages may still be experimental)
        indent = {
          enable = true,
        },

        -- Incremental selection (optional but nice)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },
}

