{ config, pkgs, ... }:

{
  # SDDM — дисплей-менеджер (экран входа в систему).
  services.displayManager.sddm.enable = true;

  # Сам KDE Plasma 6.
  services.desktopManager.plasma6.enable = true;

  #Hyprland
  programs.hyprland.enable = true;

  # Раскладки клавиатуры: английская и русская,
  # переключение по Alt+Shift.
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle"; 
  };

  # CUPS — служба печати. Здесь же, потому что это тоже часть десктопа.
  services.printing.enable = true;
}