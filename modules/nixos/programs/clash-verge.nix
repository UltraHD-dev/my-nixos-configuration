{ config, pkgs, ... }:

{
  programs.clash-verge = {
    enable = true;
    tunMode = true;      # TUN-режим — перехватывает весь трафик
    serviceMode = true;  # системный сервис, чтобы работало без запущенного GUI
  };
}