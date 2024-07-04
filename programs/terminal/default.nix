{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configuration stuff ...
  imports = [
    # Import anything to do with the terminal here
    ../shell
  ];

  home.packages = [
    pkgs.alacritty
    pkgs.alacritty-theme
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      import = ["${pkgs.alacritty-theme}/tokyo-night.toml"];
      env.TERM = "alacritty";
    };
  };
}
