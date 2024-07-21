{ pkgs, ... }:
let
  adguardPort = 3000;
in {

  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
      # allowDHCP = true;
      port = adguardPort;

      # settings = {
      #   # https://github.com/NixOS/nixpkgs/issues/246461
      #   filtering = {
      #     rewrites = [
      #       {
      #         domain = "ad.home";
      #         answer = "10.11.12.101:3000";
      #       }
      #     ];
      #   };
      # };

    };

    nginx.virtualHosts."my.home" = {
      # addSSL = true;
      # enableACME = true;
      locations."/adguard" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
  };

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

  networking.firewall.allowedTCPPorts = [ 80 53 443 3000 ];
  networking.firewall.allowedUDPPorts = [ 80 53 443 ];
}