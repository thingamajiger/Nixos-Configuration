{ config, pkgs, ... }:

{
  home.username = "tmajig";
  home.homeDirectory = "/home/tmajig";

  home.stateVersion = "26.05";

  # User packages
  home.packages = with pkgs; [
    fastfetch
    btop
    cava
  ];

  # Programs
  programs.git.enable = true;

programs.lutris = {
  enable = true;

  protonPackages = with pkgs; [
    proton-ge-bin
  ];

  defaultWinePackage = pkgs.proton-ge-bin;
};
  
  programs.bash = {
  enable = true;

  shellAliases = {
    hconf = "nano /etc/nixos/home/main/hypr/hyprland.lua";
    wconf = "nano /etc/nixos/home/main/waybar/style.css";
    dconf = "nano /etc/nixos/home/main/dunst/dunstrc";
    rconf = "nano /etc/nixos/home/main/rofi/config.rasi";
    kconf = "nano /etc/nixos/home/main/kitty/kitty.conf";
    gconf = "nano /etc/nixos/home/main/gtk-3.0/settings.ini";
    mconf = "nano /etc/nixos/main.nix";
    nconf = "nano /etc/nixos/configuration.nix";
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
  };
};  

  # Main rice
  home.file.".config/hypr".source = ./home/main/hypr;
  home.file.".config/waybar".source = ./home/main/waybar;
  home.file.".config/dunst".source = ./home/main/dunst;
  home.file.".config/rofi".source = ./home/main/rofi;
  home.file.".config/kitty".source = ./home/main/kitty;

  # GTK
  home.file.".config/gtk-3.0".source = ./home/main/gtk-3.0;
  home.file.".config/gtk-4.0".source = ./home/main/gtk-4.0;
}
