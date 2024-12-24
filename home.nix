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
    _1password-cli
    argocd
    awscli
    bash
    bat
    cargo
    clang
    cmake
    conftest
    fontforge
    gcc
    gnutls
    jsonnet
    jq
    k9s
    kubectl
    kubectl-neat
    kubectl-tree
    kubectx
    kubernetes-helm
    kubeseal
    kustomize
    nodePackages.markdownlint-cli2
    nodePackages.npm
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.yarn
    openssl
    openssh
    open-policy-agent
    opentofu
    # pinentry
    protobuf
    reviewdog
    ripgrep
    rustc
    rustfmt
    s3cmd
    shfmt
    sqlite
    stern
    wget
    xz
    yamlfmt
    yq
    zstd
  ] ++ (if stdenv.isLinux then [
    # Add your Linux packages here
    make
    multipass
    pinentry
  ] else if stdenv.isDarwin then [
    # Add your macOS packages here
    iterm2
    slack
    brave
    yubikey-manager
  ] else []);

  # Conditional settings based on the operating system
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    XDG_CONFIG_HOME = "$HOME/.config";
    NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXPKGS_ALLOW_INSECURE = "1";
  };

  imports = [
    ./font.nix
    ./go.nix
    ./git.nix
    ./neovim.nix
    ./python.nix
    ./zsh.nix
  ]; 
}
