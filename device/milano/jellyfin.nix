{
  pkgs,
  ...
}:
{

  environment.systemPackages = with pkgs; [
     
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    
  }

    # 8096/tcp is used by default for HTTP traffic. You can change this in the dashboard.
    # 8920/tcp is used by default for HTTPS traffic. You can change this in the dashboard.
    # 1900/udp is used for service auto-discovery. This is not configurable.
    # 7359/udp is also used for auto-discovery. This is not configurable.


}