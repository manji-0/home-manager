{ config, pkgs, lib, ... }:
let
  username = builtins.getEnv "USER";
in
{
  home.packages = with pkgs; [
    gnupg
  ];

  programs.git = {
    enable = true;
    userName = "Wataru Manji";
    userEmail = if username == "manji0" then
      "manji@linux.com"
    else
      "wataru.manji@lycorp.co.jp";
    aliases = {
        st = "status";
        ci = "commit";
        sw = "switch";
    };
    extraConfig.pull.rebase = true;
  };
}