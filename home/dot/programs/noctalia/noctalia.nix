{ config, pkgs, noctalia, ... }:

{
  imports = [ noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      shell = {
        corner_radius_scale = 1.0;
      };

      # Динамическая тема из обоев
      theme = {
        mode = "dark";
        palette_source = "wallpaper";
      };

      bar.default = {
        background_opacity = 0.0; # Прозрачный фон
        position = "top";
        thickness = 36;
        capsule = true;          # Скругленный "плавающий" бар
        capsule_radius = 12.0;
        
        start = [ "launcher" "workspaces" ];
        center = [ "clock" ];
        end = [ "media" "network" "volume" "battery" "tray" "control-center" "session" ];
      };

      widget.clock.format = "{:%H:%M}";
      widget.workspaces.style = "focus_hint";
    };
  };
}