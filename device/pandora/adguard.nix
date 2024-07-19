{ pkgs, ... }:

with lib;
let
  adguardPort = 3000;
in {

    environment.systemPackages = with pkgs; [
     adguardhome # cockpit
  ];


    services = {
      adguardhome = {
        enable = true;
        openFirewall = true;
        port = adguardPort;
      };
    };
}