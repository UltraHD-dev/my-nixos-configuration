{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "UltraHD-dev";
    userEmail = "egor.mondik@icloud.com";
  };
}