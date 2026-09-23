{ pkgs, ... }:
let
  # Обои рабочего стола.
  # По умолчанию — тёмные обои NixOS "moonscape" (подходят к gruvbox-теме).
  # Хочешь свои: положи картинку в репозиторий и замени путь на ./walls/твой.png
  wallpaper =
    "${pkgs.nixos-artwork.wallpapers.moonscape}/share/wallpapers/moonscape/contents/images/nix-wallpaper-moonscape.png";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = [ wallpaper ];
      wallpaper = [
        {
          monitor = "";
          path = wallpaper;
        }
      ];
    };
  };
}