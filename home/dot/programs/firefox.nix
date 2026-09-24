{ config, pkgs, firefox-addons, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      extensions = {
        force = true;

        packages = with  firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          darkreader
        ];
      };
      settings."extensions.autoDisableScopes" = 0;
    };

    policies.ExtensionSettings = {
      "immersive-translate@immersivetranslate.com" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/immersive-translate/latest.xpi";
      };
    };
  };
}