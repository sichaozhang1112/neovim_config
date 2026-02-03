# Neovim Config — Plugins Overview 🧩

This repository is a personal Neovim configuration (Lua) that uses `lazy.nvim` as the plugin manager. The config lives at the repo root (`init.lua`) and plugin specs are under `lua/plugins/`.

Quick start 🚀

- Clone this repo into your Neovim config directory (example):

```sh
# Backup existing config then
git clone <this-repo> ~/.config/nvim
nvim --headless -c 'quit'
```

- `lazy.nvim` is bootstrapped automatically by `lua/config/lazy.lua` (it clones the stable branch if missing).

Plugin manager
--------------
- lazy.nvim — fast, modern plugin manager. GitHub: https://github.com/folke/lazy.nvim ⚡

Core plugins (what's included) 🎒

Below are the main plugins referenced by this config with short descriptions and links.

- Snacks — UI & pickers: `folke/snacks.nvim` — https://github.com/folke/snacks.nvim 🥨
  - Central picker/dashboard/utility plugin used heavily for keymaps and explorer-like actions.

- Opencode — AI-ish actions & interactive operator: `NickvanDyke/opencode.nvim` — https://github.com/NickvanDyke/opencode.nvim 🧠
  - Integrates with `snacks.nvim` and provides `ask()`/`select()` utilities.

- Avante — workspace AI / assistant (optional): `yetone/avante.nvim` — https://github.com/yetone/avante.nvim 🤖
  - Includes optional providers (copilot/openai) and many optional dependencies.

- Telescope — fuzzy finder (disabled by default): `nvim-telescope/telescope.nvim` — https://github.com/nvim-telescope/telescope.nvim 🔭

- Nvim-tree — file tree (disabled by default): `nvim-tree/nvim-tree.lua` — https://github.com/nvim-tree/nvim-tree.lua 🌳

- Treesitter — syntax & parsing (disabled by default): `nvim-treesitter/nvim-treesitter` — https://github.com/nvim-treesitter/nvim-treesitter 🌲

- LSP & completion stack:
  - `mason-org/mason.nvim` — https://github.com/mason-org/mason.nvim 🧰
  - `mason-org/mason-lspconfig.nvim` — https://github.com/mason-org/mason-lspconfig.nvim
  - `neovim/nvim-lspconfig` — https://github.com/neovim/nvim-lspconfig 🔌
  - `hrsh7th/nvim-cmp` and related sources: https://github.com/hrsh7th/nvim-cmp ✨
  - `hrsh7th/cmp-nvim-lsp`, `hrsh7th/cmp-buffer`, `hrsh7th/cmp-path`, `hrsh7th/cmp-cmdline`
  - `onsails/lspkind.nvim` (icons for completion) — https://github.com/onsails/lspkind.nvim

- UI / status / buffers:
  - `nvim-lualine/lualine.nvim` — https://github.com/nvim-lualine/lualine.nvim 🎛️
  - `akinsho/bufferline.nvim` — https://github.com/akinsho/bufferline.nvim 🗂️
  - `nvim-tree/nvim-web-devicons` — https://github.com/nvim-tree/nvim-web-devicons (icons)

- Editing helpers:
  - `windwp/nvim-autopairs` — https://github.com/windwp/nvim-autopairs ⌘
  - `numToStr/Comment.nvim` — https://github.com/numToStr/Comment.nvim 💬
  - `mhartington/formatter.nvim` — https://github.com/mhartington/formatter.nvim 🧹

- Git / tooling:
  - `f-person/git-blame.nvim` — https://github.com/f-person/git-blame.nvim 🐙

- Copilot integration:
  - `github/copilot.vim` — https://github.com/github/copilot.vim 🤖

- Colorschemes:
  - `bluz71/vim-nightfly-colors` — https://github.com/bluz71/vim-nightfly-colors 🌃
  - `bluz71/vim-moonfly-colors` — https://github.com/bluz71/vim-moonfly-colors 🌙

- Misc / optional:
  - `vim-scripts/DoxygenToolkit.vim` — https://github.com/vim-scripts/DoxygenToolkit.vim 📄
  - `fgheng/winbar.nvim` — https://github.com/fgheng/winbar.nvim 🏷️
  - `SmiteshP/nvim-navic` & `SmiteshP/nvim-gps` — navigation helpers

Dependencies (external tools) 🧩

Several plugins require external binaries or language servers. The common ones used or referenced here:

- stylua — Lua formatter (used by `formatter.nvim`). https://github.com/JohnnyMorganz/StyLua
- clang-format — C/C++ formatter
- clangd — C/C++ LSP server
- pyright — Python LSP server (or use `pylsp`/`pyright`)
- busted — Lua test runner (if you add tests)
- luacheck — Lua linter

Install external formatters / LSPs via your package manager or the `mason` UI included in the config.

How plugin loading works ⚙️

- Plugins are listed under `lua/plugins/*.lua` and imported by `lua/config/lazy.lua` (see `spec = { { import = "plugins" } }`).
- `lazy.nvim` bootstraps itself if missing (clone stable branch) — you do not need to install it manually.
- Many plugins are lazy-loaded with events or `enabled = false` (user opted out). Check individual plugin files to see keymaps and config.

Disabled plugins & rationale 🔒
--------------------------------
- **Telescope** — `nvim-telescope/telescope.nvim` (disabled by default): this config prefers `folke/snacks.nvim` pickers and the integrated UX from `opencode.nvim` for most fuzzy-finder workflows. Telescope is left disabled to avoid duplicate picker UI and to keep the experience consistent. If you rely on Telescope-specific extensions, enable it in the plugin spec under `lua/plugins/`.
- **Nvim-tree** — `nvim-tree/nvim-tree.lua` (disabled by default): Snacks + custom keymaps cover explorer-like actions and project navigation in a way that fits this config's workflow. Nvim-tree is disabled to avoid maintaining two different file-explorer paradigms.
- **Treesitter** — `nvim-treesitter/nvim-treesitter` (disabled by default): Treesitter provides advanced highlighting and parsing but requires a build step and external parser installs. It's optional here to keep a minimal, fast startup for users who don't need those features out of the box.
- **Avante** — `yetone/avante.nvim` (disabled by default): Avante is a workspace AI/assistant plugin that pulls in optional providers (Copilot/OpenAI) and additional dependencies. It's disabled by default to avoid loading AI integrations and their background services unless you explicitly opt in.

How to enable a plugin
- Edit the plugin spec under `lua/plugins/` (find the file for the plugin, e.g. `lua/plugins/telescope.lua` or the file where the plugin is declared) and set `enabled = true` in the returned table, or remove the `enabled = false` line.
- Restart Neovim and run `:Lazy sync` (or use the `lazy.nvim` UI) to install any newly enabled plugins.

Why Snacks is preferred
- Snacks (`folke/snacks.nvim`) provides a small, opinionated set of UI primitives (pickers, popups, dashboards) that this config uses as a single, consistent surface for interactive actions. Replacing multiple UI plugins with Snacks reduces overlap and keeps mappings/UX consistent across features.

Configuration notes 📝

- Keymaps and behavior are defined alongside plugin specs (see `lua/plugins/snacks.lua`, `lua/plugins/opencode.lua`, etc.).
- Copilot mapping: Ctrl-j accepts suggestions (see `lua/plugins/copilot.lua`).
- The `formatter.nvim` config sets up a `BufWritePost` autocommand to `FormatWrite` by default.

Contributing & Extending ✨

1. Add a new plugin file under `lua/plugins/` (snake_case) and return a table following existing patterns.
2. Keep `require()`s local and guard optional plugins with `pcall(require, ...)` where appropriate.
3. Run `stylua .` before committing and optionally `luacheck .` to lint.

Example: add a plugin

Create `lua/plugins/my_plugin.lua`:

```lua
return {
  { "author/plugin-name", config = function() end },
}
```

Then restart Neovim — `lazy.nvim` will discover the new spec and install it.

Support & License ❤️

This is a personal config for convenience and learning. Use what you like and adapt freely. No warranty. If you want improvements or additions, open an issue or PR in your own fork.

Enjoy! 🎉
