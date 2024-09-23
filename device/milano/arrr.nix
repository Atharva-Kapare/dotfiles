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
            "/Media/qbitvpn:/config"
            "/Media/data:/data"
            "/etc/localtime:/etc/localtime:ro"
        ];
        autoStart = true;
    };

    sonarr = {
      image = "lscr.io/linuxserver/sonarr:latest";
      extraOptions = [
          "--network=container:qbitVPN"
      ];
      ports = [
          "8989:8989" # For non-SSL connections
          # "9897:9897" # For SSL connections
      ];
      environment = {
        PUID = "1000";
        # PGID = "991";
        PGID = "1000";
      };
      volumes = [
          "/Media/Shows:/tv"
          "/Media/sonarr:/config"
          "/etc/localtime:/etc/localtime:ro"
      ];
      autoStart = true;
    };
  };

  # networking.firewall.allowedTCPPorts = [ 8989 ];

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

  };

}