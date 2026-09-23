{ config, pkgs, ... }:

{
  # NetworkManager управляет и проводными, и Wi-Fi подключениями.
  # Он же даёт GUI в KDE. Это стандарт для десктопа.
  networking.networkmanager.enable = true;

  # Если понадобится корпоративный прокси, раскомментируйте:
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}