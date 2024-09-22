{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
     
  ];

  systemd.tmpfiles.rules = [
    "d /krusader 0770 - users - -"
  ];

  virtualisation.oci-containers.containers = {
    krusader = {
        image = "docker.io/binhex/arch-krusader:latest";
        extraOptions = [
            "--privileged=true"
        ];
        ports = [
            "6080:6080" # This is the webUI
        ];
        environment = {
            WEBUI_PORT = "8081";
            PUID = "0";
            PGID = "0";
        };
        volumes = [
          "/etc/localtime:/etc/localtime:ro"
          "/krusader:/config"
        ];
        autoStart = true;
    };
  };

  services = {
    nginx.virtualHosts."files.milano.io" = {
        # addSSL = true;
        # enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:6080/vnc.html?resize=remote&host=localhost&port=6080&&autoconnect=1";
          proxyWebsockets = true;
        };
    };

  };

}