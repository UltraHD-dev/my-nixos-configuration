{ config, pkgs, ... }:

{
  # Исправление для тачпада HTIX5288 (Hynitron).
  # udev ошибочно определяет его как мышь/pointing stick,
  # а не как тачпад. Это правило принудительно ставит ID_INPUT_TOUCHPAD.
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="event*", ATTRS{name}=="HTIX5288*", \
      ENV{ID_INPUT_TOUCHPAD}="1", \
      ENV{ID_INPUT_TOUCHPAD_INTEGRATION}="internal", \
      ENV{ID_INPUT_MOUSE}="0", \
      ENV{ID_INPUT_POINTINGSTICK}="0"
  '';
}