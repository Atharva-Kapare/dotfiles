{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
     
  ];

  services = {
    homepage-dashboard = {
      enable = true;
      openFirewall = true;
      listenPort = 8082;
      
    };

    nginx.virtualHosts."home.io" = {
      # addSSL = true;
      # enableACME = true;
      default = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8082";
        proxyWebsockets = true;
      };
    };
  };


}