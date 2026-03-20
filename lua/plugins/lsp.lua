return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local luasnip = require("luasnip")

    local capabilities = cmp_lsp.default_capabilities()

    -- ========================
    -- Global diagnostic keymaps
    -- ========================
    vim.keymap.set("n", "<leader>ds", vim.diagnostic.open_float,
      { desc = "Show diagnostic for current line" })
    vim.keymap.set("n", "dp", vim.diagnostic.goto_prev,
      { desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "dn", vim.diagnostic.goto_next,
      { desc = "Go to next diagnostic" })
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist,
      { desc = "Open diagnostic in location list" })

    -- ========================
    -- Global LSP keymaps
    -- ========================
    vim.keymap.set("n", "K", vim.lsp.buf.hover,
      { desc = "Show hover documentation" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition,
      { desc = "Go to definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references,
      { desc = "List references" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
      { desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
      { desc = "Code actions" })
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help,
      { desc = "Signature help" })

    -- on_attach callback (currently just a placeholder)
    local on_attach = function(_, bufnr)
    end

    -- Initialize UI and Mason
    require("fidget").setup({})
    mason.setup()

    -- Setup LSPs via mason-lspconfig
    mason_lspconfig.setup({
      ensure_installed = {
        "ansiblels",
        "jsonls",
        "pyright",
        "ts_ls"
      },
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        pyright = function()
          local venv = os.getenv("VIRTUAL_ENV")
          local python_path = venv and (venv .. "/bin/python") or vim.fn.exepath("python")
          lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              python = {
                pythonPath = python_path,
              },
            },
          })
        end,
        ts_ls = function()
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "javascript.ejs" },
            settings = {
              javascript = { suggest = { autoImports = true } },
              typescript = { suggest = { autoImports = true } },
            },
          })
        end,
      },
    })

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
  end,
}

