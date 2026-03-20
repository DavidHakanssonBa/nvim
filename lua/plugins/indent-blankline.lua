return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",  -- ibl = new entrypoint since v3
  opts = {
    indent = { char = "│" }, -- character for indentation guide
    scope = { enabled = true }, -- highlight current scope
  },
}
