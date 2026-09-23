{ config, pkgs, lib, ... }:

{
  # --- Загрузчик ---
  # systemd-boot — простой и надёжный загрузчик для UEFI.
  boot.loader.systemd-boot.enable = true;
  # Разрешаем NixOS менять EFI-переменные (нужно для записи загрузочных записей).
  boot.loader.efi.canTouchEfiVariables = true;

  # Самое свежее ядро из nixpkgs. Хорошо для нового железа.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Параметр ядра, который вы уже добавили — отключает управление питанием PCIe.
  # Обычно нужно, чтобы Wi-Fi стабильно работал на некоторых ноутбуках.
  boot.kernelParams = [ "pcie_port_pm=off" ];

  # --- Идентификация машины ---
  networking.hostName = "nixos";

  # Часовой пояс
  time.timeZone = "Asia/Yekaterinburg";

  # ВАЖНО: никогда не меняйте эту строку после установки.
  # Она фиксирует версию формата данных, чтобы апгрейды не сломали систему.
  system.stateVersion = "26.05";
}