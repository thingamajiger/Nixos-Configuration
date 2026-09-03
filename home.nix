{ config, pkgs, ... }:

{
  home.username = "tmajig";
  home.homeDirectory = "/home/tmajig";

home.file.".config/gtk-3.0/gtk.css".text = ''
  .thunar,
  .thunar window,
  .thunar .view {
    background-color: rgba(20, 22, 25, 0.55);
  }
'';

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    fastfetch
    btop
    cava
  ];

  programs.git.enable = true;

programs.bash = {
  enable = true;

  shellAliases = {
    nconf = "sudo nano /etc/nixos/configuration.nix";
    hconf = "nano ~/.config/hypr/hyprland.lua";
  };
};
}
