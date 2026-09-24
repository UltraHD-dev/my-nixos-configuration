{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true; # Запускать Noctalia как systemd-сервис
    settings = {
      general = {
        telemetryEnabled = false; # Отключаем телеметрию
        showChangelogOnStartup = false; # Убираем окно чейнджлога
      };
    };
  };
}