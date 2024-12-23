{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [];

  programs.go = {
    enable = true;
    goPath = ".go";
    goBin = ".go/bin";
  };
}