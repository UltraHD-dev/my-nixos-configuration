{ config, pkgs, tokyonight, ... }:

{
  imports = [ tokyonight.homeManagerModules.default ];

  tokyonight.enable = true;
  tokyonight.style = "storm";  # или "night", "moon", "day"

  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
  };
}