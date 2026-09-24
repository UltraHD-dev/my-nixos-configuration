{ ... }:

{
  imports = [
    ./nix.nix
    ./desktop.nix
    ./audio.nix
    ./networking.nix
    ./users.nix
    ./programs/default.nix
    ./locale.nix
    ./plymouth.nix
    ./fonts.nix
    ./bluetooth.nix
    ./touchpad-fix.nix 
    ./overlays.nix
  ];
}