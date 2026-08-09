{ config, lib, pkgs, inputs, ... }:

{
  # ==========================================================================
  # IMPORTS
  # ==========================================================================

  imports = [
    ./hardware-configuration.nix
    ./SilentSDDM/nix/module.nix
    inputs.spicetify-nix.nixosModules.default
  ];


  # ==========================================================================
  # NIX
  # ==========================================================================

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;


  # ==========================================================================
  # BOOT
  # ==========================================================================

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    theme = "/etc/nixos/HyperFluent-GRUB-Theme/nixos";
    configurationLimit = 10;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 15;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.kernelModules = [
    "nvme"
  ];


  # ==========================================================================
  # NETWORKING
  # ==========================================================================

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;


  # ==========================================================================
  # DESKTOP
  # ==========================================================================

  services.xserver.enable = true;

  programs.hyprland.enable = true;


  # ==========================================================================
  # DISPLAY MANAGER
  # ==========================================================================

  services.displayManager.sddm.enable = true;

  programs.silentSDDM = {
    enable = true;
    theme = "default";

    backgrounds = {
      abandoned = ./SilentSDDM/backgrounds/abandoned.jpg;
    };

    settings = {
      LoginScreen = {
        background = "abandoned.jpg";
      };
    };
  };


  # ==========================================================================
  # USERS
  # ==========================================================================


  users.users.tmajig = {
    isNormalUser = true;
    description = "tmajig";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
  };

  security.sudo.wheelNeedsPassword = true;


  # ==========================================================================
  # SERVICES
  # ==========================================================================

  services.flatpak.enable = true;
  services.input-remapper.enable = true;

  security.polkit.enable = true;


  # ==========================================================================
  # FONTS
  # ==========================================================================

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.code-new-roman
    nerd-fonts.commit-mono
  ];


  # ==========================================================================
  # PACKAGES
  # ==========================================================================

  environment.systemPackages = with pkgs; [
    hyprland
    xwayland
    waybar
    kitty
    rofi
    awww
    firefox
    thunar
    fastfetch
    vesktop
    pwvucontrol
    wev
    unzip
    dunst
    adwaita-icon-theme
    gnome-themes-extra
    libnotify
    nerd-fonts.jetbrains-mono
    git
    banana-cursor
    persepolis
    gparted
    btop
    cava
    bluetui
    obs-studio
    hyprshot
    wf-recorder
    vlc
    imv
    desktop-file-utils
    easyeffects
    spicetify-cli
    bun
    picard
    strawberry
    input-remapper
    tumbler
    ffmpegthumbnailer
    libgsf
    kdePackages.kdenlive
    losslesscut-bin

    (pkgs.stdenv.mkDerivation {
      pname = "SilentSDDM";
      version = "1.0";

      src = ./SilentSDDM;

      installPhase = ''
        mkdir -p $out/share/sddm/themes/SilentSDDM
        cp -r ./* $out/share/sddm/themes/SilentSDDM/
        cp -r ./.??* $out/share/sddm/themes/SilentSDDM/ 2>/dev/null || true
      '';
    })
  ];


  # ==========================================================================
  # GAMING
  # ==========================================================================

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };


  # ==========================================================================
  # SPICETIFY
  # ==========================================================================

  programs.spicetify = {
    enable = true;

    theme = {
      name = "Glassify";
      src = ./themes/Glassify;
    };
  };


  # ==========================================================================
  # SYSTEM VERSION
  # ==========================================================================

  system.stateVersion = "26.05";
}
