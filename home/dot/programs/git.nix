{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "UltraHD-dev";
        email = "egor.mondik@icloud.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        lg = "log --oneline --graph --decorate";
      };
    };
  };
}