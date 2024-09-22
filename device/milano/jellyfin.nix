{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
     
  ];

  users.groups.arrr = { };
  users.users."ak".extraGroups = [ "arrr" ];

  systemd.tmpfiles.rules = [
    "d /Media 0770 - arrr - -"
  ];

  services = {

    # 8096/tcp is used by default for HTTP traffic. You can change this in the dashboard.
    # 8920/tcp is used by default for HTTPS traffic. You can change this in the dashboard.
    # 1900/udp is used for service auto-discovery. This is not configurable.
    # 7359/udp is also used for auto-discovery. This is not configurable.
    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "arrr";
    };

    jellyseerr = {
      enable = true;
      port = 5055;
      openFirewall = true;
    };


    nginx.virtualHosts."jellyfin.milano.io" = {
        # addSSL = true;
        # enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8096/";
          proxyWebsockets = true;
        };
    };

    nginx.virtualHosts."jellyseerr.milano.io" = {
        # addSSL = true;
        # enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:5055/";
          proxyWebsockets = true;
        };
    };
  };

  
}