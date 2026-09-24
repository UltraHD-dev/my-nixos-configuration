{ config, pkgs, firefox-addons, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      extensions = {
        force = true;

        packages = with firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          darkreader
        ];
      };

      # 👇 Настройки для тёмной темы
      settings = {
        "extensions.autoDisableScopes" = 0;
        # Следовать системной тёмной теме (из dconf)
        "layout.css.prefers-color-scheme.content-override" = 0;
        # Принудительно включить встроенную тёмную тему Firefox
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };

    policies.ExtensionSettings = {
      "{5efceaa7-f3a2-4e59-a54b-85319448e305}" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/immersive-translate/latest.xpi";
      };
    };
  };
}