{
  config,
  pkgs,
  inputs,
  ...
}: let
  shellAliases = {
    nv = "nvim";
    gs = "git status";
    ga = "git add -p";
    gc = "git commit -m";
    la = "ls -la";
    t = "tmux";
    lg = "lazygit";
    cat = "bat";
  };

  tmux-tokyo-night =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-tokyo-night";
      version = "1.5.2";
      src = pkgs.fetchFromGitHub {
        owner = "fabioluciano";
        repo = "tmux-tokyo-night";
        rev = "1.5.2";
        # sha256 = "sha256-OCUuNubXKk91+tqVGRKrFx1abhLOiog7hyas7CrI4Fk=";
        sha256 = "sha256-G5SV19811i0GBkXUDiQ5xerfkTxeQ9jdhM7k22XiQCg=";
      };
      rtpFilePath = "tmux-tokyo-night.tmux";
    };
in {
  # Configuration stuff ...
  imports = [
    # Import anything to do with the terminal here
  ];

  home.packages = [
    pkgs.tmux
    pkgs.bat
  ];

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    keyMode = "vi";
    plugins = [
      {
        plugin = tmux-tokyo-night;
        extraConfig = ''
          set -g @plugin 'fabioluciano/tmux-tokyo-night'
          set -g @theme_variation 'night'
        '';
      }
      # {
      #   plugin = pkgs.tmuxPlugins.catppuccin;
      # } # pkgs.tmuxPlugins.catppuccin
    ];
    # set -g terminal-overrides "alacritty:Tc" # Deleted this from the extraConfig
    extraConfig = ''
      set -g default-terminal "alacritty"
      set -ga terminal-overrides ",alacritty:Tc"
      set-environment -g COLORTERM "truecolor"
    '';
  };

  # programs.zsh.enable = true;
  # programs.zsh.shellAliases = shellAliases;
  programs.bash.enable = true;
  programs.bash.shellAliases = shellAliases;
}
