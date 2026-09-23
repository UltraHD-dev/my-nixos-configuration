{ ... }:

{
  imports = [
    ./vscode.nix
    ./git.nix
    ./fastfetch/fastfetch.nix
    ./hyprland/default.nix
    ./neovim/neovim.nix
    ./waybar/default.nix
    ./wofi/default.nix
  ];
}