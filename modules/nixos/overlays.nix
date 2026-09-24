{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-yazi-flavors.overlays.default
  ];
}