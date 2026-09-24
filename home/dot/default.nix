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

  # 👇 ГЛОБАЛЬНАЯ ТЕМА: dconf + переменная окружения
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };

  # 👇 Принудительно для GTK-приложений
  home.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";
  };

  # 👇 ПОРТАЛЫ — это ключевой момент
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome  # 👈 для GTK-настроек
    ];
    config.common = {
      default = [ "gnome" "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.Settings" = [ "gnome" ];  # 👈 это читает dconf
    };
  };

  # Стабильный канал пакетов
  home.packages = with pkgs; [
    tree
    git
    curl
    yazi
    typst
    mpv                    # видео (и музыка)
    qimgv                  # фото (и базовое видео)
    zathura                # PDF
    wf-recorder            # Для записи
    obs-studio             # -

    # ------------Для Hyprland---------------
    kitty                          # терминал
    grim                           # скриншоты
    slurp                          # выбор области
    wl-clipboard                   # работа с буфером
    brightnessctl                  # яркость
    pavucontrol                    # звук
    xwayland-satellite             # поддержка X11-приложений
    awww                           # Для обоев и анимаций
    nerd-fonts.jetbrains-mono      # Для шрифтов с иконками (Nerd Fonts)
  ]

  # Unstable канал пакетов
  ++ (with pkgsUnstable; [
    ayugram-desktop
  ]);
}