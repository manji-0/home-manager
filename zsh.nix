{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    starship
  ];

  programs.zsh = {
    autocd = true;
    autosuggestion = {
        enable = true;
        strategy = ["history"];
    };
    defaultKeymap = "emacs";
    enable = true;
    enableCompletion = true;
    oh-my-zsh.enable = false;
    initExtra = ''
        eval "$(starship init zsh)"
    '';
  };
}