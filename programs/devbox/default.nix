{
  config,
  pkgs,
  inputs,
  ...
}
: {
  # Configuration stuff ...
  imports = [
    # Import anything to do with the terminal here
  ];

  home.packages = [
    pkgs.devbox
  ];
}
