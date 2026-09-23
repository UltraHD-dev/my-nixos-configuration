{ config, pkgs, lib, ... }:

let
  # Список пакетов, которым разрешено быть несвободными.
  # Если поставите ещё один несвободный пакет и получите ошибку —
  # просто добавьте сюда его имя (как оно называется в nixpkgs).
  allowedUnfree = [
    "vscode"
  ];
in
{
  # Разрешаем только перечисленные несвободные пакеты.
  # Всё остальное несвободное по-прежнему будет блокироваться.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) allowedUnfree;

  # Включаем flakes и новый CLI на уровне системы.
  # Это чтобы при переустановке не настраивать вручную.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
}