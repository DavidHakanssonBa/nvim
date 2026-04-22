local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

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
    "ts_ls",
    "yamlls",
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
    yamlls = function()
    lspconfig.yamlls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            yaml = {
                customTags = { "!reference sequence" },
                schemas = {
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                        ".gitlab-ci.yml",
                        ".gitlab-ci.yaml",
                        ".gitlab/**/*.yml",
                        ".gitlab/**/*.yaml",
                    },
                },
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
