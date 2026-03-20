# Neovim Config

A minimal, well-organized Neovim configuration with LSP, completion, and modern tooling.

## Features

- **LSP Support** — Python (Pyright), TypeScript/JavaScript (ts_ls), JSON, YAML with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Code Completion** — [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with snippet support
- **Fuzzy Finding** — [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **Search & Replace** — [Spectre](https://github.com/nvim-pack/nvim-spectre)
- **Tree-sitter Integration** — Syntax highlighting, folding, and context awareness
- **Git Integration** — [Gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- **Indent Guides** — [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)

## Requirements

- Neovim ≥ 0.9.0
- ripgrep (for Telescope live grep)

## Installation

```shell
git clone https://github.com/johe37/nvim.git ~/.config/nvim
```

Lazy plugin manager will bootstrap on first launch.

## Key Bindings

View all keybindings:

```vim
:Telescope keymaps
```

Common commands:
- `<leader>ff` — Find files
- `<leader>sg` — Live grep
- `<leader>sr` — Search and replace
- `K` — Hover documentation
- `gd` — Go to definition
- `gr` — Find references
- `<leader>rn` — Rename symbol
- `<leader>ca` — Code actions

## Project Structure

```
lua/
├── config/          # Core settings
│   ├── options.lua
│   ├── keymaps.lua
│   └── autocmds.lua
└── plugins/         # Plugin specs & configs
    ├── colorscheme.lua
    ├── lsp/         # LSP & completion setup
    ├── telescope.lua
    └── ...
```
