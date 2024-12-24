# Nix home-manager configuration

## Installation
### 1. Install Nix (requires `sudo`)

    curl -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

### 2. Clone this repository

    mkdir ~/.config
    git clone https://github.com/manji-0/home-manager.git ~/.config/home-manager

### 3. Install home-manager

    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    export NIXPKGS_ALLOW_UNFREE=1
    nix-shell '<home-manager>' -A install

#### If an error occurs, try the following

    sudo rm /nix/store/<previous-id>/bin/nvim
    nix-shell '<home-manager>' -A install

## Update config

### 1. Edit `.config/home-manager/*.nix`

    vim ~/.config/home-manager/{module}.nix

### 2. Apply changes

    home-manager switch

