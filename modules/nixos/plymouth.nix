{ config, pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };

  # 🔧 ФИКС ДЛЯ INTEL: разрешаем Plymouth использовать simple-drm сразу
  boot.kernelParams = [
    "quiet"
    "splash"
    "plymouth.use-simpledrm"   # 👈 вот это
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];

  # 🔧 Загружаем драйвер Intel в initrd как можно раньше
  boot.initrd.availableKernelModules = [
    "i915"   # 👈 драйвер Intel для N95
  ];

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
}