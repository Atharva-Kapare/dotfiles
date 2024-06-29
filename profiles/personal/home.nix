{
  config,
  pkgs,
  userSettings,
  nixvim,
  ...
}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../../programs/nvim
    ../../programs/terminal
    ../../programs/tmux
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  home.packages = with pkgs; [
    btop
    git
    # neovim
    thefuck
    starship

    (nerdfonts.override {fonts = ["Hack"];})

    alacritty
    cinnamon.nemo-with-extensions

    spotify
    signal-desktop
    bitwarden-desktop
    brave

    vscode-fhs
  ];

  # Alacritty config
  # programs.alacritty = {
  #   enable = true;
  # };

  # programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "Atharva-Kapare";
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ssh.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
