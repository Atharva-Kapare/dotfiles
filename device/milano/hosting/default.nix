{
  pkgs,
  ...
}:
let
  cockpitPodman = pkgs.callPackage ./cockpitPodman.nix { };
in
{

  environment.systemPackages = with pkgs; [
  ];

  users.groups.hosting = {
    gid = 900;
  };

  users.users."ak".extraGroups = [ "hosting" ];

  systemd.tmpfiles.rules = [
    "d /config/minecraft-server 0775 - hosting - -"
  ];

  # Enable Podman
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  virtualisation.oci-containers.containers = {
    minecraft-server = {
      image = "itzg/minecraft-server";
      extraOptions = [
      ];
      ports = [
          "25565:25565"
      ];
      environment = {
        EULA = "TRUE";
        MEMORY = "4G"; 
      };
      volumes = [
        "/config/minecraft-server:/data"
      ];
      autoStart = true;
    };
  };
}