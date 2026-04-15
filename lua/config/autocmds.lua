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

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
