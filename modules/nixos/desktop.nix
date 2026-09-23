{ config, pkgs, ... }:

{
  # X11-сервер. Нужен для KDE Plasma 6 на X11.
  # Если когда-нибудь перейдёте на Wayland-only, можно будет отключить.
  services.xserver.enable = true;

  # SDDM — дисплей-менеджер (экран входа в систему).
  services.displayManager.sddm.enable = true;

  # Сам KDE Plasma 6.
  services.desktopManager.plasma6.enable = true;

  # Hyprland
  programs.hyprland.enable =true;

  # Раскладки клавиатуры: английская и русская,
  # переключение по Alt+Shift.
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";  # именно toggle, а не toogle
  };

  # CUPS — служба печати. Здесь же, потому что это тоже часть десктопа.
  services.printing.enable = true;
}