{ config, pkgs, pkgsUnstable, gako-neovim, inputs, ... }:

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

  # 👇 ГЛОБАЛЬНАЯ ТЕМА GTK
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
  };

  # 👇 ГЛОБАЛЬНАЯ ТЕМА QT (для Dolphin, KWrite и др. Qt-приложений)
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
    kde.settings = {
      kdeglobals = {
        General = {
          ColorScheme = "BreezeDark";
        };
        Icons = {
          Theme = "breeze-dark";
        };
      };
    };
  };

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

  # 👇 ПОРТАЛЫ XDG
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
      };
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
    glib
    dconf
    gsettings-desktop-schemas
    adw-gtk3
    gnome-themes-extra
    
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
    lavat
    pipes-rs
  ]);
}