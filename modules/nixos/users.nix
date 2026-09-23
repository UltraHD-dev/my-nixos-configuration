{ config, pkgs, ... }:

{
  users.users."dot" = {
    isNormalUser = true;                # обычный пользователь, не системный
    description = "Egor";               # отображаемое имя
    extraGroups = [                     # дополнительные группы
      "networkmanager"                  # управление сетями без sudo
      "wheel"                           # право на sudo
    ];
    # Пакетов здесь больше нет — они переехали в Home Manager.
  };
}