{ config, pkgs, ... }:

{
  # HTIX5288 определяется как два устройства: event8 (мышь) и event9 (тачпад).
  # Hyprland видит только event8, а event9 игнорирует.
  # Это правило принудительно помечает event9 как тачпад.
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="event9", SUBSYSTEM=="input", \
      ATTRS{name}=="HTIX5288*", \
      ENV{ID_INPUT_TOUCHPAD}="1", \
      ENV{ID_INPUT_TOUCHPAD_INTEGRATION}="internal"
  '';
}