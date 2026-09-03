{ config, pkgs, ... }:

{
  home.username = "tmajig";
  home.homeDirectory = "/home/tmajig";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    fastfetch
    btop
    cava
  ];

  programs.git.enable = true;

  programs.bash.enable = true;
}
