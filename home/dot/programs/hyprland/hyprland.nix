{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua"; # Указываем Home Manager, что используем Lua-формат

    # Подключаем твой внешний файл hyprland.lua
    extraConfig = builtins.readFile ./hyprland.lua;
  };
}