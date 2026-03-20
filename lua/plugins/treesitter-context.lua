return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true,           -- Enable this plugin
        max_lines = 3,           -- How many lines the context window should show
        min_window_height = 0,   -- Minimum editor height to enable context
        line_numbers = true,     -- Show line numbers in context window
        multiline_threshold = 20,-- Max lines for a node to be displayed
        trim_scope = 'outer',    -- 'inner' or 'outer'
        mode = 'cursor',         -- 'cursor' or 'topline'
        separator = nil,         -- Use "─" for a separator line
        zindex = 20,             -- Z-index of the context window
        on_attach = nil          -- Custom callback when attaching
      })
    end,
  },
}
