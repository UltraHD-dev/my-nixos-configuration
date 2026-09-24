{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # ==========================================
    # 1. ЛИДЕР-КЛАВИША (ПРОБЕЛ)
    # ==========================================
    globals.mapleader = " ";

    # ==========================================
    # 2. LSP И АВТОДОПОЛНЕНИЕ
    # ==========================================
    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        gopls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        pyright.enable = true;
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

    # ==========================================
    # 3. ФАЙЛОВОЕ ДЕРЕВО (NEO-TREE)
    # ==========================================
    plugins.neo-tree = {
      enable = true;
    };

    # ==========================================
    # 4. ПОИСК И НАВИГАЦИЯ (TELESCOPE)
    # ==========================================
    plugins.telescope = {
      enable = true;
      extensions = {
        file-browser.enable = true;
        fzf-native.enable = true;
      };
    };

    # ==========================================
    # 5. ПОДСВЕТКА СИНТАКСИСА (TREESITTER)
    # ==========================================
    plugins.treesitter = {
      enable = true;
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        nix go rust python lua vim vimdoc json yaml toml markdown markdown_inline bash regex
      ];
    };

    # ==========================================
    # 6. ДОПОЛНИТЕЛЬНЫЕ ПЛАГИНЫ
    # ==========================================
    plugins.gitsigns.enable = true;
    plugins.which-key.enable = true;
    plugins.web-devicons.enable = true;

    # ==========================================
    # 7. АВТОФОРМАТ ПРИ СОХРАНЕНИИ (CONFORM)
    # ==========================================
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
        formatters_by_ft = {
          nix = [ "nixfmt" ];
          go = [ "gofmt" ];
          python = [ "ruff_format" ];
        };
      };
    };

    extraPackages = with pkgs; [
      nixfmt-rfc-style
      go
      gopls
      python3
      ruff
    ];

    # ==========================================
    # 8. ТЕМА
    # ==========================================
    colorschemes.tokyonight.enable = true;

    # ==========================================
    # 9. КЛАВИШИ (В СТИЛЕ IDE)
    # ==========================================
    keymaps = [
      # --- Файловое дерево ---
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options.desc = "Toggle File Explorer"; }

      # --- Поиск (Telescope) ---
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live Grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>"; options.desc = "Help Tags"; }

      # --- LSP (Навигация и действия) ---
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; options.desc = "Go to Definition"; }
      { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; options.desc = "Go to Declaration"; }
      { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; options.desc = "References"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; options.desc = "Hover Info"; }
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; options.desc = "Code Action"; }
      { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; options.desc = "Rename Symbol"; }
      { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; options.desc = "Prev Diagnostic"; }
      { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; options.desc = "Next Diagnostic"; }
      { mode = "n"; key = "<leader>cd"; action = "<cmd>lua vim.diagnostic.open_float()<cr>"; options.desc = "Line Diagnostics"; }

      # --- Управление окнами ---
      { mode = "n"; key = "<leader>wj"; action = "<C-w>j"; options.desc = "Window Down"; }
      { mode = "n"; key = "<leader>wk"; action = "<C-w>k"; options.desc = "Window Up"; }
      { mode = "n"; key = "<leader>wl"; action = "<C-w>l"; options.desc = "Window Right"; }
      { mode = "n"; key = "<leader>wh"; action = "<C-w>h"; options.desc = "Window Left"; }
      { mode = "n"; key = "<leader>w="; action = "<C-w>="; options.desc = "Equal Windows"; }
      { mode = "n"; key = "<leader>wo"; action = "<C-w>o"; options.desc = "Only This Window"; }
      { mode = "n"; key = "<leader>t"; action = "<cmd>split | terminal<cr>"; options.desc = "Terminal"; }

      # --- Буферы ---
      { mode = "n"; key = "<leader>bn"; action = "<cmd>bnext<cr>"; options.desc = "Next Buffer"; }
      { mode = "n"; key = "<leader>bp"; action = "<cmd>bprevious<cr>"; options.desc = "Previous Buffer"; }
      { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<cr>"; options.desc = "Delete Buffer"; }

      # --- Форматирование ---
      { mode = "n"; key = "<leader>f"; action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>"; options.desc = "Format Buffer"; }

      # --- Базовое ---
      { mode = "n"; key = "<C-s>"; action = "<cmd>w<cr>"; options.desc = "Save File"; }
      { mode = "n"; key = "<leader>qq"; action = "<cmd>qa<cr>"; options.desc = "Quit All"; }
    ];
  };
}