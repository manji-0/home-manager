{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    pyenv
    ruff
    uv
  ];

  programs.ruff = {
    settings = ''
      cache-dir = "~/.cache/ruff"
      fix = true
      line-length = 120
      output-format = "github"
      [format]
      docstring-code-format = true
      '';
  };
}
