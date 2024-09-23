{
  config,
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    # ./hardware-configuration.nix
    /etc/nixos/hardware-configuration.nix
    ../common.nix

    ./homepage-dashboard.nix
    ./cockpit
    ./jellyfin.nix
    ./arrr.nix
    ./krusader.nix
    
  ];

  # Useful other development tools
  environment.systemPackages = with pkgs; [

  ];

  systemd.tmpfiles.rules = [ "d /var/ftp 2770 users users - -" ];

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
    userlist = [ "ak" ];
    userlistEnable = true;
    localRoot = "/var/ftp";
    extraConfig = ''
      local_umask=007
    '';
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  # 80 for nginx
  # 21 for the ftp server, also open 20 if you want ftp client

  networking.firewall.allowedTCPPorts = [ 80 21 ];
  networking.firewall.allowedUDPPorts = [ 80 ];

  services.openssh.enable = true;

  # security.acme.defaults.email = userSettings.email;
  # security.acme.acceptTerms = true;
}
