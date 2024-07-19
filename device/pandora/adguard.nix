{ pkgs, ... }:

with lib;
let
  adguardPort = 3000;
in {

  environment.systemPackages = with pkgs; [
    adguardhome # adguardhome
  ];

  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
      allowDHCP = true;
      port = adguardPort;

      settings = {
        # https://github.com/NixOS/nixpkgs/issues/246461
        schema_version = 20;
      };

    };
  };
}