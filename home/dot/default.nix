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

  # Иконки приложений: нужны для wofi (режим drun), GTK-приложений,
  # трея и т.п. Без выбранной икон-темы многие иконки не отображаются.
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Стабильный канал пакетов
  home.packages = with pkgs; [
    tree
    git
    curl
  ]

  # Unstable канал пакетов
  ++ (with pkgsUnstable; [
  ]);
}