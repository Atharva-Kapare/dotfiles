{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
     
  ];

    systemd.tmpfiles.rules = [
        "d /Media/data 0770 - arrr - -"
        "d /Media/qbitvpn 0770 - arrr - -"
        "d /Media/sonarr 0770 - arrr - -"
        "d /Media/prowlarr 0770 - arrr - -"

        "d /config/prowlarr 0770 - arrr - -"
        "d /config/sonarr 0770 - arrr - -"
        "d /config/radarr 0770 - arrr - -"
        "d /config/qbitvpn 0770 - arrr - -"

        "d /data/torrents/movies 0770 - arrr - -"
        "d /data/torrents/tv 0770 - arrr - -"
        "d /data/media/movies 0770 - arrr - -"
        "d /data/media/tv 0770 - arrr - -"
    ];

  virtualisation.oci-containers.containers = {
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
        # PGID = "991";
        PGID = "1000";
        UMASK=002;
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

    nginx.virtualHosts."prowlarr.milano.io" = {
      locations."/" = {
        proxyPass = "http://localhost:9696/";
        proxyWebsockets = true;
      };
    };

  };

}