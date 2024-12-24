{ config, pkgs, lib, ... }:
let
  username = builtins.getEnv "USER";
  inherit (pkgs) stdenv;
in
{
  home.packages = with pkgs; [
    act
    actionlint
    action-validator
    gh
    gibo
    git
    gnupg
  ];

  programs.git = {
    enable = true;
    userName = "Wataru Manji";
    userEmail = if username == "manji0" && !stdenv.isDarwin then
      "manji@linux.com"
    else
      "wataru.manji@lycorp.co.jp";
    lfs.enable = true;
    aliases = {
        st = "status";
        ci = "commit";
        sw = "switch";
    };
    extraConfig.pull.rebase = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
      editor = "nvim";
      pager = "nvimpager";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
