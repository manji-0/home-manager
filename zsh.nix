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
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      ls = "ls --color=auto ";
      ll = "ls -la ";
      terraform = "tofu";
      k = "kubectl";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      sudo = "sudo ";
    };
    initExtra = ''
        eval "$(starship init zsh)"
        eval "$(gh completion -s zsh)"
    '';
  };
}
