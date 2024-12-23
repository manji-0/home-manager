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
    make
    ripgrep
    rustc
    yq
  ] ++ (if stdenv.isLinux then [
    # Add your Linux packages here
  ] else if stdenv.isDarwin then [
    # Add your macOS packages here
    iterm2
    slack
    brave
  ] else []);

  # Example of setting up a program configuration
  #programs.zsh = {
  #  enable = true;
  #  initExtra = ''
  #      eval "$(starship init zsh)"
  #  '';
  #};

  # Conditional settings based on the operating system
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  } // mkIf (stdenv.isLinux) {
    XDG_CONFIG_HOME = "$HOME/.config";
  } // mkIf (stdenv.isDarwin) {
    XDG_CONFIG_HOME = "$HOME/Library/Preferences";
  };

  imports = [
    ./go.nix
    ./git.nix
    ./neovim.nix
    ./python.nix
    ./zsh.nix
  ] ++ (if stdenv.isLinux then [
    # Add Linux only imports here
  ] else if stdenv.isDarwin then [
    # Add MacOS only imports here
    ./brew.nix
  ] else []);


}