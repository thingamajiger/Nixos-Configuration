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

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.initrd.kernelModules = [
    "nvme"
  ];

systemd.user.services.nixos-fake-graphical-session = {
  wantedBy = [ "default.target" ];
  serviceConfig = {
    Type = "oneshot";
    ExecStart = "${pkgs.systemd}/bin/systemctl --user start nixos-fake-graphical-session.target";
    RemainAfterExit = true;
  };
};

  # ==========================================================================
  # NETWORKING
  # ==========================================================================

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;


  # ==========================================================================
  # DESKTOP
  # ==========================================================================

  services.xserver.enable = true;

  programs.hyprland = {
  enable = true;
  withUWSM = false;
};

  xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];
};

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
    extraGroups = [ "wheel" "networkmanager" "video" "input" "cdrom" ];
  };

  security.sudo.wheelNeedsPassword = true;


  # ==========================================================================
  # SERVICES
  # ==========================================================================

  services.flatpak.enable = true;
  services.input-remapper.enable = true;
  services.udisks2.enable = true;

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
    terminus_font
    comic-mono
    comic-relief
  ];


  # ==========================================================================
  # PACKAGES
  # ==========================================================================

  environment.systemPackages = with pkgs; [
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
    cdrtools
    dvdplusrwtools
    p7zip
    xarchiver
    yt-dlp
    curl
    gnused
    patch
    aria2
    botan3
    lunar-client
    eza
    fetch
    neovim
    swayosd
    nwg-look
    gnome-themes-extra
    adwaita-icon-theme 
    gnumake
    cmake
    ninja 
    hyprland
    nwg-dock-hyprland    
    socat
    pulseaudio
    unrar
    

    inputs.millennium.packages."${pkgs.system}".millennium-steam

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

  programs.k3b.enable = true;

  console = {
  earlySetup = true;
  font = "${pkgs.terminus_font}/share/consolefonts/ter-120n.psf.gz";
  packages = with pkgs; [ terminus_font ];
  keyMap = "us";
};

  # ==========================================================================
  # GAMING
  # ==========================================================================

  programs.steam = {
    enable = true;

    package = pkgs.millennium-steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };


  # ==========================================================================
  # SPICETIFY
  # ==========================================================================

  programs.spicetify = {
    enable = true;

    theme = {
      name = "Hazy";
      src = ./themes/Hazy;
    };
  };


  # ==========================================================================
  # SYSTEM VERSION
  # ==========================================================================

  system.stateVersion = "26.05";

  # ==========================================================================
  # GARBAGE COLLECTION
  # ==========================================================================

  systemd.services.delete-old-generations = {
    description = "Delete old NixOS generations";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.nix}/bin/nix-env --delete-generations +5 -p /nix/var/nix/profiles/system && ${pkgs.nix}/bin/nix-collect-garbage'";
    };
  };

  systemd.timers.delete-old-generations = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };

  nix.optimise.automatic = true;
}
