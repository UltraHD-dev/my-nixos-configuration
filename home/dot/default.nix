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
    curl

    # Для Hyprland
    kitty         # терминал
    waybar        # бар
    mako          # уведомления
    swaybg        # обои
    hyprlock      # блокировка
    hypridle      # idle-менеджмент
    grim          # скриншоты
    slurp         # выбор области
    wl-clipboard  # работа с буфером
    brightnessctl # яркость
    pavucontrol   # звук
    xwayland-satellite  # поддержка X11-приложений
  ]

  # Unstable канал пакетов
  ++ (with pkgsUnstable; [
  ]);
}