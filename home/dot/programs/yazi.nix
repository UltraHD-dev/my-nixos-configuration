{ config, pkgs, pkgsUnstable, ... }:

{
  programs.yazi = {
    enable = true;
    package = pkgsUnstable.yazi;
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

    plugins = with pkgs.yaziPlugins; {
      inherit smart-enter chmod ouch mediainfo;
      full-border = { package = full-border; setup = true; };
      git = { package = git; setup = true; };
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Chmod"; }
        { on = [ "c" "p" ]; run = "plugin ouch"; desc = "Compress"; }
        { on = [ "c" "u" ]; run = "plugin ouch"; desc = "Extract"; }
        { on = [ "l" ]; run = "plugin smart-enter"; desc = "Smart enter"; }
      ];
    };
  };

  # Весь theme.toml пишем вручную — с flavor и с правилами в новом синтаксисе
  xdg.configFile."yazi/theme.toml".text = ''
    [flavor]
    dark = "tokyonight"
    light = "tokyonight"

    [[filetype.rules]]
    url = "*"
    is = "orphan"
    fg = "#f7768e"

    [[filetype.rules]]
    url = "*"
    is = "link"
    fg = "#7aa2f7"

    [[filetype.rules]]
    url = "*/"
    is = "link"
    fg = "#7aa2f7"

    [[filetype.rules]]
    url = "*"
    is = "exec"
    fg = "#9ece6a"

    [[filetype.rules]]
    mime = "image/*"
    fg = "#bb9af7"

    [[filetype.rules]]
    mime = "{audio,video}/*"
    fg = "#ff9e64"

    [[filetype.rules]]
    mime = "application/x-bzip"
    fg = "#bb9af7"
  '';
}