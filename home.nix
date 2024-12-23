{ config, pkgs, lib, ... }:

let
  username = builtins.getEnv "USER";
  inherit (pkgs) stdenv;
  inherit (lib) mkIf;
in
{
  home.username = username;
  home.stateVersion = "24.11";

  home.homeDirectory = if stdenv.isLinux then
      "/home/${username}"
    else if stdenv.isDarwin then
      "/Users/${username}"
    else
      throw "Unsupported system";
  
  programs.home-manager.enable = true;

  # Define your packages and configurations here
  home.packages = with pkgs; [
    bash
    bat
    cargo
    clang
    gcc
    jq
    kubectl
    kubectl-neat
    kubectl-tree
    kubectx
    opentofu
    ripgrep
    rustc
    wget
    yq
  ] ++ (if stdenv.isLinux then [
    # Add your Linux packages here
    make
  ] else if stdenv.isDarwin then [
    # Add your macOS packages here
    iterm2
    slack
    brave
  ] else []);

  # Conditional settings based on the operating system
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  imports = [
    ./go.nix
    ./git.nix
    ./neovim.nix
    ./python.nix
    ./zsh.nix
  ]; 
}
