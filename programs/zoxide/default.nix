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
    pkgs.zoxide
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
