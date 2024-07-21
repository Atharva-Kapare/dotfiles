{ pkgs, ... }:
let
  adguardPort = 3000;
in {

  environment.systemPackages = with pkgs; [
    # adguardhome # adguardhome
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [ adguardPort ];
      allowedUDPPorts = [ 53 ];
    };
  };

  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
      allowDHCP = true;
      port = adguardPort;

      settings = {
        # https://github.com/NixOS/nixpkgs/issues/246461
        # schema_version = 20;
        users = {
          name = "ak";
          password = "$2y$10$lD/VNPDBWKcdQpD0GIP53OREp/OkxvNt1akuGPuYxoK824Ofz3vwS";
        };
      };

    };
  };

  # services.adguardhome = {
  #   enable = true;
  #   host = "0.0.0.0";
  #   port = adguardPort;
  #   allowDHCP = true;
  #   openFirewall = true;
  # };

  # virtualisation.oci-containers.containers.adguard = {
  #   hostname = "adguard";
  #   autoStart = true;
  #   image = "adguard/adguardhome";
  #   ports = [
  #     # DNS server
  #     "53:53/tcp"
  #     "53:53/udp"
  #     # "853:853/tcp" # DNS over TLS
  #     # "853:853/udp" # DNS over QUIC

  #     # DHCP server
  #     # "67:67/udp"
  #     # "68:68/tcp"
  #     # "68:68/udp"

  #     # Admin panel + DNS over HTTPS
  #     "80:80/tcp"
  #     "443:443/tcp"
  #     "443:443/udp"
  #     "3000:3000/tcp" # Web interface

  #     # DNSCrypt
  #     # "5443:5443/tcp"
  #     # "5443:5443/udp"

  #     # "6060:6060/tcp" # Debugging
  #   ];
  #   volumes = [
  #     "/volumes/adguard_workdir:/opt/adguardhome/work"
  #     "/volumes/adguard_confdir:/opt/adguardhome/conf"
  #   ];
  # };

  # networking.firewall.allowedTCPPorts = [ 80 53 443 3000 ];
  # networking.firewall.allowedUDPPorts = [ 80 53 443 ];
}