{
  # Агент polkit — показывает графическое окно ввода пароля
  # (подключение дисков, запуск админ-утилит и т.п.).
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # Home Manager 26.05 по умолчанию генерирует Lua-конфиг, но настройки
    # здесь написаны в синтаксисе hyprlang (переменные $mainMod, bind, env и т.д.).
    # Поэтому явно указываем hyprlang, чтобы создавался hyprland.conf.
    configType = "hyprlang";
    settings = {
      env = [
        # Hint Electron apps to use Wayland
        "NIXOS_OZONE_WL,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,$HOME/screens"
      ];

      monitor = ",1920x1080@60,auto,1";
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "$terminal -e sh -c 'ranger'";
      "$menu" = "wofi";

      exec-once = [
        "waybar"
        "swaync"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 5;

        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";

        resize_on_border = true;

        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = false;
        };
      };

      animations = {
        enabled = false;
      };

      input = {
        kb_layout = "us,ru,";
        kb_options = "grp:caps_toggle";
      };

      gestures = {
        # workspace_swipe теперь включается через hl.gesture в новом синтаксисе,
        # а отдельной опции gestures:workspace_swipe в 0.55 больше нет.
        workspace_swipe_invert = false;
        workspace_swipe_forever = true;
      };

      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Новый синтаксис windowrule (Hyprland 0.55+):
      #   "эффект значение, match:свойство regex"
      windowrule = [
        "border_size 0, match:float false, match:workspace w[t1]"

        "float true, match:class ^(mpv|imv|showmethekey-gtk)$"
        "move 990 60, match:class ^(showmethekey-gtk)$"
        "size 900 170, match:class ^(showmethekey-gtk)$"
        "pin true, match:class ^(showmethekey-gtk)$"
        "no_initial_focus true, match:class ^(showmethekey-gtk)$"
        "no_focus true, match:class ^(showmethekey-gtk)$"

        "workspace 3, match:class ^(obsidian)$"
        "workspace 3, match:class ^(zathura)$"
        "workspace 4, match:class ^(com.obsproject.Studio)$"
        "workspace 5, match:class ^(telegram)$"
        "workspace 5, match:class ^(vesktop)$"
        "workspace 6, match:class ^(teams-for-linux)$"

        "suppress_event maximize, match:class .*"
        "no_focus true, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"

        "opacity 0.0 override, match:class ^(xwaylandvideobridge)$"
        "no_anim true, match:class ^(xwaylandvideobridge)$"
        "no_initial_focus true, match:class ^(xwaylandvideobridge)$"
        "max_size 1 1, match:class ^(xwaylandvideobridge)$"
        "no_blur true, match:class ^(xwaylandvideobridge)$"
        "no_focus true, match:class ^(xwaylandvideobridge)$"
      ];

      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    };
  };
}