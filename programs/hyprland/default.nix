{
  config,
  pkgs,
  inputs,
  ...
} 
 {
  # Configuration stuff ...
  imports = [
  ];

    wayland.windowManager.hyprland = {
        enable = true;

        "$terminal" = "alacritty";
        "$fileManager" = "nemo"
        
    };
}
