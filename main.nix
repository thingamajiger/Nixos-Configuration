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
  programs.bash.enable = true;

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
