{ config, pkgs, lib, ... }:

{
  # Включаем Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # Включать адаптер при загрузке
    settings = {
      General = {
        Experimental = true;      # Показывать заряд батареи устройств
        FastConnectable = true;   # Быстрое подключение
      };
      Policy = {
        AutoEnable = true;        # Автоматически включать адаптер
      };
    };

    # Временный фикс для BlueZ 5.86 (баг с подключением наушников).
    # Применяется ТОЛЬКО если версия BlueZ < 5.87.
    # Когда NixOS обновится до 5.87+, фикс автоматически отключится.
    package = lib.mkIf (lib.versionOlder pkgs.bluez.version "5.87") (
      (pkgs.bluez.override {
        bluez-headers = pkgs.bluez-headers.overrideAttrs (old: {
          version = "5.84";
          src = pkgs.fetchurl {
            url = "mirror://kernel/linux/bluetooth/bluez-5.84.tar.xz";
            hash = "sha256-W6c9Aw97AAh9Z4ALDjIWAa7A+JKCfHLlosg5DYyIaxE=";
          };
        });
      }).overrideAttrs (old: {
        patches = [
          (pkgs.fetchurl {
            name = "static.patch";
            url = "https://lore.kernel.org/linux-bluetooth/20250703182908.2370130-1-hi@alyssa.is/raw";
            hash = "sha256-4Yz3ljsn2emJf+uTcJO4hG/YXvjERtitce71TZx5Hak=";
          })
        ];
      })
    );
  };

  # Утилита для управления (GUI + CLI)
  services.blueman.enable = true;
}