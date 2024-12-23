{ config, pkgs, lib, ... }:
let
  username = builtins.getEnv "USER";
  inherit (pkgs) stdenv;
in
{
  home.packages = with pkgs; [
    gh
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
    aliases = {
        st = "status";
        ci = "commit";
        sw = "switch";
    };
    extraConfig.pull.rebase = true;
  };
}
