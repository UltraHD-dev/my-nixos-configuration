{ config, pkgs, pkgsUnstable, ... }:

{
  programs.neovim = {
    enable = true;
    
    # Сделать Neovim редактором по умолчанию для команд EDITOR и VISUAL
    defaultEditor = true;

    # Создать алиасы vim и vi, указывающие на nvim
    viAlias = true;
    vimAlias = true;

    # Дополнительные плагины из nixpkgs
    # plugins = with pkgs.vimPlugins; [
    #   vim-nix
    #   telescope-nvim
    # ];

    # Произвольный Lua/VimL-конфиг
    # extraConfig = ''
    #   set number
    #   set relativenumber
    # '';
  };
}