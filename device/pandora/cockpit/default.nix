{
  pkgs,
  ...
}:
let
  cockpitPodman = pkgs.callPackage ./cockpitPodman.nix { inherit pkgs; };
{

  environment.systemPackages = with pkgs; [
     cockpit # cockpit
  ];

  services = {
    cockpit = {
      enable = true;
      port = 9090;
      openFirewall = true;
      settings = {
        WebService = {
          AllowUnencrypted = true;
        };
      };
    };

    nginx.virtualHosts."cockpit.home.io" = {
      # addSSL = true;
      # enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:9090/";
        proxyWebsockets = true;
      };
    };
  };


}