{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
     
  ];

  virtualisation.oci-containers.containers = {
    qbitVPN = {
        image = "binhex/arch-qbittorrentvpn:latest";
        extraOptions = [ "--cap-add=NET_ADMIN" ];
        ports = [
            "6882:6881"
            "6882:6881/udp"
            "8081:8081"
            "8118:8118"
        ];
        environment = {
            WEBUI_PORT = "8081";
            PUID = "600";
            PGID = "100";
            VPN_ENABLED = "yes";
            VPN_CLIENT = "wireguard";
            STRICT_PORT_FORWARD = "yes";
            ENABLE_PRIVOXY = "yes";
            DEBUG = "true";
            DELUGE_DAEMON_LOG_LEVEL = "debug";
            DELUGE_WEB_LOG_LEVEL = "debug";
        };
        autoStart = true;
    }
  };

  services = {
    nginx.virtualHosts."qbit.milano.io" = {
        # addSSL = true;
        # enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8081/";
          proxyWebsockets = true;
        };
    };

  };

}