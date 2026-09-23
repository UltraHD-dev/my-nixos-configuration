{ config, pkgs, lib, ... }:

{
  # --- Загрузчик ---
  boot.loader = {
    systemd-boot.enable = false;

    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

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