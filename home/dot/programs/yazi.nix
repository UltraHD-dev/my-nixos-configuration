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
}