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

    ./homepage-dashboard.nix
    ./cockpit
    ./jellyfin.nix
    ./arrr.nix
    ./krusader.nix
    
  ];

  # Useful other development tools
  environment.systemPackages = with pkgs; [

  ];

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
  networking.firewall.allowedUDPPorts = [ 80 ];

  services.openssh.enable = true;

  # security.acme.defaults.email = userSettings.email;
  # security.acme.acceptTerms = true;
}
