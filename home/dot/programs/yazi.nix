{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    # Зависимости для превью и работы плагинов
    extraPackages = with pkgs; [
      ffmpegthumbnailer # видео-превью
      poppler           # PDF
      fd                # поиск
      ripgrep           # grep
      fzf               # fuzzy-поиск
      jq                # JSON
      imagemagick       # картинки
      ouch              # архивы (zip, tar, rar)
      unar              # rar-архивы (если ouch не справится)
      mediainfo         # метаданные аудио/видео
      exiftool          # EXIF для фото
    ];

    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "mtime";
      };
    };

    # Тема
    flavors = {
      tokyonight = pkgs.yaziFlavors.tokyonight-storm;
    };
    theme = {
      flavor = {
        dark = "tokyonight";
        light = "tokyonight";
      };
    };

    # Плагины
    plugins = with pkgs.yaziPlugins; {
      inherit full-border;    # рамка вокруг интерфейса
      inherit chmod;          # изменение прав
      inherit ouch;           # работа с архивами
      inherit smart-enter;    # умный Enter (открывает файл/входит в папку)
      inherit git;            # git-интеграция
      inherit mediainfo;      # превью метаданных медиа
    };

    # Инициализация плагинов
    initLua = ''
      require("full-border"):setup()
      require("smart-enter"):setup()
      require("git"):setup()
      require("mediainfo"):setup()
    '';

    # Кейбинды
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = [ "c" "p" ];
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = [ "c" "u" ];
          run = "plugin ouch";
          desc = "Extract with ouch";
        }
      ];
    };
  };
}