# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    # ./hardware-configuration.nix
    /etc/nixos/hardware-configuration.nix
    ../common.nix
    
    ./cockpit.nix
    ./adguard.nix
    ./homepage-dashboard.nix
    ./home-assistant

  ];

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    # docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
  ];

  virtualisation =
  {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers.backend = "podman";
    containers.enable = true;
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  # security.acme.defaults.email = userSettings.email;
  # security.acme.acceptTerms = true;
  
}
