return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      -- find
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope Find Help" },
      { "<leader>fc", function()
          require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
        end, desc = "Find Files in Current Dir" },

      -- grep
      { "<leader>fw", "<cmd>Telescope live_grep<cr>",  desc = "Telescope Live Grep" },
      { "<leader>fd", "<cmd>LiveGrepInDir<cr>", desc = "Telescope Live Grep in Directory" },
      { "<leader>sc", function()
          require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })
        end, desc = "Live Grep in Current Dir" },

      -- etc.
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Telescope Resume Last Picker" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Telescope Keymaps" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--no-ignore-vcs",
            "--glob", "!.git/",
            "--glob", "!node_modules/",
            "--glob", "!venv/",
            "--glob", "!.venv/",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--no-ignore-vcs",
              "--glob", "!.git/*",
              "--glob", "!node_modules/*",
              "--glob", "!venv/*",
              "--glob", "!.venv/*",
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      vim.api.nvim_create_user_command("LiveGrepInDir", function()
        vim.ui.input({ prompt = "Grep in directory: ", completion = "dir" }, function(input)
          if input and input ~= "" then
            require("telescope.builtin").live_grep({ cwd = input })
          end
        end)
      end, {})

    end,
  },
}
