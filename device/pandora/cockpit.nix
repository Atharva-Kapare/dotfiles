{
  pkgs,
  ...
}:
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

    nginx.virtualHosts."my.home.io" = {
      # addSSL = true;
      # enableACME = true;
      locations."/cockpit" = {
        proxyPass = "http://127.0.0.1:9090";
        proxyWebsockets = true;
      };
    };
  };


}