{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    pyenv
    ruff
    uv
  ];
}