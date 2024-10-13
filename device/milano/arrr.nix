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
    "d /config/jellyfin 775 - arrr - -"
    "d /config/plex 775 - arrr - -"
    "d /config/plexTranscode 775 - arrr - -"
    "d /config/jellyseerr 775 - arrr - -"
    "d /config/prowlarr 775 - arrr - -"
    "d /config/sonarr 775 - arrr - -"
    "d /config/radarr 775 - arrr - -"
    "d /config/qbitvpn 775 - arrr - -"

    "d /data/torrents/movies 775 - arrr - -"
    "d /data/torrents/tv 775 - arrr - -"
    "d /data/media/movies 775 - arrr - -"
    "d /data/media/tv 775 - arrr - -"
  ];

  virtualisation.oci-containers.containers = {
    jellyfin = {
      image = "ghcr.io/hotio/jellyfin";
      extraOptions = [
      ];
      ports = [
          "8096:8096"
      ];
      environment = {
        PUID = "1000";
        PGID = "991";
        # PGID = "1000";
        UMASK="002";
      };
      volumes = [
          "/config/jellyfin:/config"
          "/data/media:/data/media"
      ];
      autoStart = true;
    };

    plex = {
      image = "ghcr.io/hotio/plex";
      ports = [
        "32400:32400"
      ];
      environment = {
        PUID = "1000";
        PGID = "991";
        # PGID = "1000";
        UMASK="002";
      };
      volumes = [
        "/config/plex:/config"
        "/config/plexTranscode:/transcode"
        "/data/media:/data"
      ]
    };

    jellyseerr = {
      image = "ghcr.io/hotio/jellyseerr";
      extraOptions = [
      ];
      ports = [
          "5055:5055"
      ];
      environment = {
        PUID = "1000";
        PGID = "991";
        # PGID = "1000";
        UMASK="002";
      };
      volumes = [
          "/config/jellyseerr:/config"
      ];
      autoStart = true;
    };

    qbitVPN = {
        image = "docker.io/binhex/arch-qbittorrentvpn:latest";
        extraOptions = [
            "--sysctl=\"net.ipv4.conf.all.src_valid_mark=1\""
            "--privileged=true"
        ];
        ports = [
            "6882:6881"
            "6882:6881/udp"
            "8081:8081"
            "8118:8118"
        ];
        environment = {
            WEBUI_PORT = "8081";
            PUID = "1000";
            PGID = "991";
            VPN_ENABLED = "yes";
            VPN_PROV= "custom";
            VPN_CLIENT = "wireguard";
            STRICT_PORT_FORWARD = "yes";
            ENABLE_PRIVOXY = "yes";
            LAN_NETWORK="10.11.12.0/24";
            # DEBUG = "true";
            # DELUGE_DAEMON_LOG_LEVEL = "debug";
            # DELUGE_WEB_LOG_LEVEL = "debug";
        };
        volumes = [
            "/config/qbitvpn:/config"
            "/data/torrents:/data/torrents"
            "/etc/localtime:/etc/localtime:ro"
        ];
        autoStart = true;
    };

    prowlarr = {
      image = "ghcr.io/hotio/prowlarr";
      extraOptions = [
      ];
      ports = [
          "9696:9696"
      ];
      environment = {
        PUID = "1000";
        PGID = "991";
        # PGID = "1000";
        UMASK="002";
        RUN_OPTS="--ProxyConnection=10.11.12.19:8118";
      };
      volumes = [
          "/config/prowlarr:/config"
      ];
      autoStart = true;
    };

    flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      extraOptions = [
      ];
      ports = [
          "8191:8191"
      ];
      environment = {
      };
      volumes = [
      ];
      autoStart = true;
    };

    radarr = {
      image = "ghcr.io/hotio/radarr";
      extraOptions = [
      ];
      ports = [
          "7878:7878"
      ];
      environment = {
        PUID = "1000";
        PGID = "991";
        # PGID = "1000";
        RUN_OPTS="--ProxyConnection=10.11.12.19:8118";
      };
      volumes = [
          # - /<host_folder_config>:/config
          # - /<host_folder_data>:/data

          "/config/radarr:/config"
          "/data:/data"
      ];
      autoStart = true;
    };

    sonarr = {
      image = "ghcr.io/hotio/sonarr";
      extraOptions = [
      ];
      ports = [
          "8989:8989" # For non-SSL connections
          # "9897:9897" # For SSL connections
      ];
      environment = {
        PUID = "1000";
        PGID = "991";
        # PGID = "1000";
        RUN_OPTS="--ProxyConnection=10.11.12.19:8118";
      };
      volumes = [
          # - /<host_folder_config>:/config
          # - /<host_folder_data>:/data

          "/config/sonarr:/config"
          "/data:/data"
      ];
      autoStart = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 9696 8191 8989 ];
  networking.firewall.allowedUDPPorts = [ 9696 8191 8989 ];

  services = {

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
    nginx.virtualHosts."qbit.milano.io" = {
        # addSSL = true;
        # enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8081/";
          proxyWebsockets = true;
        };
    };

    nginx.virtualHosts."proxy.milano.io" = {
        # addSSL = true;
        # enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8118/";
          proxyWebsockets = true;
        };
    };

    nginx.virtualHosts."sonarr.milano.io" = {
      locations."/" = {
        proxyPass = "http://localhost:8989/";
        proxyWebsockets = true;
      };
    };

    nginx.virtualHosts."radarr.milano.io" = {
      locations."/" = {
        proxyPass = "http://localhost:7878/";
        proxyWebsockets = true;
      };
    };

    nginx.virtualHosts."prowlarr.milano.io" = {
      locations."/" = {
        proxyPass = "http://localhost:9696/";
        proxyWebsockets = true;
      };
    };

  };

}