{
  config,
  pkgs,
  inputs,
  ...
}: let
  mod = "ALT";
in {
  # Configuration stuff ...
  imports = [
    ./noctalia.nix
    ./keybinds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
    };
  };
}
