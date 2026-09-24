{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    # Зависимости для превью и работы плагинов
    extraPackages = with pkgs; [
      ffmpegthumbnailer
      poppler
      fd
      ripgrep
      fzf
      jq
      imagemagick
      ouch
      unar
      mediainfo
      exiftool
    ];

    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "mtime";
      };
    };

    # Тема
    flavors = {
      tokyonight = pkgs.yaziFlavors.tokyonight-storm;
    };
    theme = {
      flavor = {
        dark = "tokyonight";
        light = "tokyonight";
      };
    };

    # Плагины
    plugins = with pkgs.yaziPlugins; {
      inherit full-border;
      inherit chmod;
      inherit ouch;
      inherit smart-enter;
      inherit git;
      inherit mediainfo;
    };

    # Инициализация плагинов
    # ВАЖНО: smart-enter НЕ имеет setup(), его нельзя вызывать здесь.
    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("mediainfo"):setup()
    '';

    # Кейбинды
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = [ "c" "p" ];
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = [ "c" "u" ];
          run = "plugin ouch";
          desc = "Extract with ouch";
        }
        {
          on = [ "l" ];
          run = "plugin smart-enter";
          desc = "Enter directory or open file";
        }
      ];
    };
  };
}