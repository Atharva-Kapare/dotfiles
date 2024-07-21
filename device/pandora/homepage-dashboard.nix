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
                {""
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
            {
              "AdGuardHome" = {
                description = "Adguard for network monitoring";
                href = "http://adguard.home.io/";
              };
            }
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

    nginx.virtualHosts."home.io" = {
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