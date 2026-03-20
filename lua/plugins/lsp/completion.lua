local cmp = require("cmp")
local luasnip = require("luasnip")

-- Completion engine config
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
    ["<Enter>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
  enabled = function()
    -- Disable completion for JSON files to avoid lag on minified files
    local context = require("cmp.config.context")
    if vim.api.nvim_buf_get_option(0, "filetype") == "json" then
      return false
    end
    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
  end,
})

-- Diagnostic UI styling
vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
