{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [];

  programs.brew = {
    enable = true;
    goPath = ".go";
    goBin = ".go/bin";
  };
}