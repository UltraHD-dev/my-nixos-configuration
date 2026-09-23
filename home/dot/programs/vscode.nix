{ config, pkgs, ... }:

{
  # Модуль Home Manager для VS Code.
  # Позволяет декларативно задавать расширения и настройки.
  programs.vscode = {
    enable = true;

    # Раскомментируйте и добавьте нужные расширения:
    # extensions = with pkgs.vscode-extensions; [
    #   jnoortheen.nix-ide
    #   ms-python.python
    # ];

    # userSettings = {
    #   "editor.fontSize" = 14;
    #   "editor.tabSize" = 2;
    # };
  };
}