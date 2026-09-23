{ config, pkgs, ... }:

{
  # NixOS-модуль Firefox. Он устанавливает браузер
  # и позволяет декларативно задавать настройки, расширения, профили.
  programs.firefox.enable = true;
}