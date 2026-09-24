{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    extraPackages = with pkgs; [
      ffmpegthumbnailer poppler fd ripgrep fzf jq
      imagemagick ouch unar mediainfo exiftool
    ];

    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "mtime";
      };
    };

    flavors = {
      tokyonight = pkgs.yaziFlavors.tokyonight-storm;
    };
    theme = {
      flavor = {
        dark = "tokyonight";
        light = "tokyonight";
      };
    };

    # Плагины с настройками через Home Manager
    plugins = with pkgs.yaziPlugins; {
      # Без setup() — просто подключаем
      inherit smart-enter chmod ouch mediainfo;

      # С setup() — Home Manager сам сгенерирует init.lua
      full-border = {
        package = full-border;
        setup = true;
      };
      git = {
        package = git;
        setup = true;
      };
    };

    # initLua больше не нужен — Home Manager сам всё сгенерирует
    # initLua = '''';

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod"; }
        { on = [ "c" "p" ]; run = "plugin ouch"; desc = "Compress"; }
        { on = [ "c" "u" ]; run = "plugin ouch"; desc = "Extract"; }
        { on = [ "l" ]; run = "plugin smart-enter"; desc = "Smart enter"; }
      ];
    };
  };
}