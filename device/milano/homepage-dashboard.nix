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

      widgets = [
        {
          resources = {
            cpu = true;
            disk = "/";
            memory = true;
          };
        }
        {
          search = {
            provider = "duckduckgo";
            target = "_blank";
          };
        }
      ];

      bookmarks = [
        {
          Developer = [
            {
              Github = [
                {
                  abbr = "GH";
                  href = "https://github.com/";
                }
              ];
            }
          ];
        }
        {
          Entertainment = [
            {
              YouTube = [
                {
                  abbr = "YT";
                  href = "https://youtube.com/";
                }
              ];
            }
          ];
        }
      ];

      services = [
        {
          "Monitoring" = [
            {
              "Cockpit" = {
                description = "Cockpit for system monitoring";
                href = "http://cockpit.milano.io/";
              };
            }
          ];
        }
        {
          "Management" = [
            
          ];
        }
        {
          "Media" = [
            {
              "Jellyfin" = {
                description = "Watch all your content";
                href = "http://jellyfin.milano.io/";
              };
            }
            {
              "Plex" = {
                description = "Watch all your content";
                href = "http://plex.milano.io/";
              };
            }
            {
              "Jellyseerr" = {
                description = "Request all your content";
                href = "http://jellyseerr.milano.io/";
              };
            }
          ];
        }
      ];
      
    };

    nginx.virtualHosts."milano.io" = {
      # addSSL = true;
      # enableACME = true;
      default = true;
      locations."/" = {
        proxyPass = "http://localhost:8082/";
        proxyWebsockets = true;
      };
    };
  };


}