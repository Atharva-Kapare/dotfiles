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
      listenPort = 80;

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
                href = "http://cockpit.home.io/";
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
                description = "Homepage is the best";
                href = "http://localhost/";
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
        proxyPass = "http://localhost:80/";
        proxyWebsockets = true;
      };
    };
  };


}