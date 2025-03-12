{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    shellcheck
    starship
    zsh-completions
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
      http = "noglob http ";
      https = "noglob https ";
      curl = "noglob curl ";
      vim = "nvim";
      vi = "nvim";
      less = "nvimpager";
      ls = "ls --color=auto ";
      ll = "ls -la ";
      terraform = "tofu";
      k = "kubectl";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      python = "/Users/manji0/.nix-profile/bin/python";
      sudo = "sudo ";
    };
    initExtra = ''
        eval "$(starship init zsh)"
        eval "$(gh completion -s zsh)"
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
    '';
  };
}
