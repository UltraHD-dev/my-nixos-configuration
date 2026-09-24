{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      shell = "${pkgs.fish}/bin/fish";
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12.0;
      window_padding_width = 10;
      background_opacity = "0.85";
      background_blur = 5;
    };
    themeFile = "tokyo_night_storm";
  };
}