{ pkgs, ... }:

with lib;
let
  adguardPort = 3000;
in {

  # environment.systemPackages = with pkgs; [
  #   adguardhome # adguardhome
  # ];

  # networking = {
  #   firewall = {
  #     allowedTCPPorts = [ adguardPort ];
  #     allowedUDPPorts = [ 53 ];
  #   };
  # };

  # services = {
  #   adguardhome = {
  #     enable = true;
  #     openFirewall = true;
  #     allowDHCP = true;
  #     port = adguardPort;

  #     settings = {
  #       # https://github.com/NixOS/nixpkgs/issues/246461
  #       schema_version = 20;
  #     };

  #   };
  # };

    services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = 3000;
    allowDHCP = true;
    openFirewall = true;
  };
  networking.firewall.allowedTCPPorts = [ 53 3000 3001 ];
}