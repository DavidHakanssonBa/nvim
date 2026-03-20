-- Set leader key
vim.g.mapleader = " "  -- Use space as leader key

-- UI Settings
vim.opt.guicursor = ""         -- Use block (fat) cursor
vim.opt.nu = true              -- Show line numbers
vim.opt.wrap = false           -- Disable line wrapping
vim.opt.termguicolors = true   -- Enable true color support
vim.opt.scrolloff = 8          -- Keep 8 lines of context when scrolling

-- Tab and Indentation
vim.opt.tabstop = 2            -- Number of spaces per tab
vim.opt.softtabstop = 2        -- Number of spaces when pressing Tab
vim.opt.shiftwidth = 2         -- Indentation width
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.smartindent = true     -- Smart indentation

-- Search
vim.o.hlsearch = true         -- Highlight search results
vim.o.incsearch = true        -- Show matches as you type

-- Match files like `*.js.ejs`, `*.ts.ejs`, `*.json.ejs`, etc.
-- and treat them as if they were the base filetype (`js`, `ts`, `json`, etc.)
vim.filetype.add({
  pattern = {
    [".*%.%a+%.ejs"] = function(path)
      -- Extract the extension before `.ejs` using Lua string pattern
      local base_ext = path:match("(%a+)%.ejs$")
      local map = {
        js = "javascript",
        yml = "yaml",
        yaml = "yaml",
        ts = "typescript",
        json = "json",
        css = "css",
        html = "html",
      }
      return map[base_ext]
    end,
  },
})
