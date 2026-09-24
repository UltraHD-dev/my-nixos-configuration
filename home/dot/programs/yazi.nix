{ config, pkgs, pkgsUnstable, lib, ... }:

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
  };

  # Принудительно перезаписываем theme.toml, игнорируя то, что генерирует Home Manager
  xdg.configFile."yazi/theme.toml".text = lib.mkForce ''
    [flavor]
    dark = "tokyonight"
    light = "tokyonight"

    [filetype]
    rules = [
      { url = "*", is = "orphan", fg = "#f7768e" },
      { url = "*", is = "link", fg = "#7aa2f7" },
      { url = "*/", is = "link", fg = "#7aa2f7" },
      { url = "*", is = "exec", fg = "#9ece6a" },
      { mime = "image/*", fg = "#bb9af7" },
      { mime = "{audio,video}/*", fg = "#ff9e64" },
      { mime = "application/x-bzip", fg = "#bb9af7" }
    ]
  '';
}