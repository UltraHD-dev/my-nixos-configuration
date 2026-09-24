{
  description = "NixOS configuration for dot@nixos";

  inputs = {
    # Основной репозиторий пакетов. Ветка 26.05 — стабильная.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # Unstable канал репозитория пакетов
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager — отдельный проект, управляет пользовательскими настройками.
    # Важно: release-26.05 должен совпадать с версией nixpkgs выше.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # Эта строка заставляет home-manager использовать тот же nixpkgs,
      # что и система. Без неё будут две разные версии пакетов — источник багов.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };

    # Firefox расширения
    firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    #Fish theme
    tokyonight = {
      url = "github:mrjones2014/tokyonight.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      # Имя "nixos" здесь — это имя хоста, по которому вы будете
      # собирать систему командой: nixos-rebuild switch --flake .#nixos
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        # specialArgs передаёт inputs (nixpkgs, home-manager и т.д.)
        # внутрь всех модулей, чтобы их можно было использовать там.
        specialArgs = { inherit inputs; };

        modules = [
          # 1. Железо конкретной машины
          ./hosts/nixos/hardware-configuration.nix

          # 2. Уникальные настройки хоста (boot, hostname, timezone)
          ./hosts/nixos/default.nix

          # 3. Все общие системные модули (одним импортом)
          ./modules/nixos/default.nix

          # 4. Подключаем Home Manager как модуль NixOS
          home-manager.nixosModules.home-manager

          # 5. Настраиваем Home Manager и подключаем конфиг пользователя
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."dot" = import ./home/dot/default.nix;

            home-manager.backupFileExtension = "backup";

            home-manager.sharedModules = [
              inputs.nixvim.homeModules.nixvim
            ];

            # Передаем unstable пакеты в Home Manager
            home-manager.extraSpecialArgs = {
              inherit (inputs) firefox-addons;
              inherit (inputs) noctalia;
              inherit (inputs) tokyonight;
              pkgsUnstable = import inputs.nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
              };
            };
          }
        ];
      };
    };
}