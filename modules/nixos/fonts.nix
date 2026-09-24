{ pkgs, ... }:

{
  # Шрифты.
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}
