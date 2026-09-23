{ config, pkgs, pkgsUnstable, inputs, ... }:

{
  # Подключаем все пользовательские программы
  imports = [
    ./programs/default.nix
  ];

  # Имя пользователя и домашняя директория.
  # Должны совпадать с тем, что в modules/nixos/users.nix.
  home.username = "dot";
  home.homeDirectory = "/home/dot";

  # Версия формата данных Home Manager.
  # Должна совпадать с версией NixOS или быть не выше.
  home.stateVersion = "26.05";

  # Стабильный канал пакетов
  home.packages = with pkgs; [
    tree 
    git

    # Hyprland пакеты
    kitty
    fuzzel
    waybar
    mako
    swaybg
    hyprpolkitagent
    hyprlock
    wlogout
    grim
    slurp
    wl-clipboard 
    brightnessctl
    kdePackages.dolphin
  ]

  # Unstable канал пакетов
  ++ (with pkgsUnstable; [
  ]);
}