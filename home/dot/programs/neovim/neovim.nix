{ config, pkgs, pkgsUnstable, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # === LSP и Автодополнение ===
    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;          # Nix
        gopls.enable = true;           # Go
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        pyright.enable = true;         # Python
      };
    };

    plugins.cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };
      };
    };
    plugins.luasnip.enable = true;

    # === Плагины для удобства ===
    plugins.telescope.enable = true;
      plugins.treesitter = {
        enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          nix
          go
          rust
          python
          lua
          vim
          vimdoc
          json
          yaml
          toml
          markdown
          markdown_inline
          bash
          regex
        ];
      };
    plugins.gitsigns.enable = true;
    plugins.which-key.enable = true;
    plugins.web-devicons.enable = true;

    # === Тема ===
    colorschemes.tokyonight.enable = true;

    # === Хоткеи (в стиле LazyVim) ===
    keymaps = [
      # Поиск (Telescope)
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live Grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>"; options.desc = "Help Tags"; }

      # LSP (Навигация)
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; options.desc = "Go to Definition"; }
      { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; options.desc = "Go to Declaration"; }
      { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; options.desc = "References"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; options.desc = "Hover Info"; }
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; options.desc = "Code Action"; }
      { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; options.desc = "Rename Symbol"; }
      { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; options.desc = "Prev Diagnostic"; }
      { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; options.desc = "Next Diagnostic"; }
      { mode = "n"; key = "<leader>cd"; action = "<cmd>lua vim.diagnostic.open_float()<cr>"; options.desc = "Line Diagnostics"; }

      # Управление окнами
      { mode = "n"; key = "<leader>wj"; action = "<C-w>j"; options.desc = "Window Down"; }
      { mode = "n"; key = "<leader>wk"; action = "<C-w>k"; options.desc = "Window Up"; }
      { mode = "n"; key = "<leader>wl"; action = "<C-w>l"; options.desc = "Window Right"; }
      { mode = "n"; key = "<leader>wh"; action = "<C-w>h"; options.desc = "Window Left"; }
      { mode = "n"; key = "<leader>w="; action = "<C-w>="; options.desc = "Equal Windows"; }
      { mode = "n"; key = "<leader>wo"; action = "<C-w>o"; options.desc = "Only This Window"; }
      { mode = "n"; key = "<leader>t"; action = "<cmd>split | terminal<cr>"; options.desc = "Terminal"; }

      # Буферы
      { mode = "n"; key = "<leader>bn"; action = "<cmd>bnext<cr>"; options.desc = "Next Buffer"; }
      { mode = "n"; key = "<leader>bp"; action = "<cmd>bprevious<cr>"; options.desc = "Previous Buffer"; }
      { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<cr>"; options.desc = "Delete Buffer"; }

      # Базовое
      { mode = "n"; key = "<C-s>"; action = "<cmd>w<cr>"; options.desc = "Save File"; }
      { mode = "n"; key = "<leader>qq"; action = "<cmd>qa<cr>"; options.desc = "Quit All"; }
    ];
  };
}