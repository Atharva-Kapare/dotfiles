# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # /etc/nixos/hardware-configuration.nix
    ../common.nix
  ];

  environment.systemPackages = [
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qtmultimedia
    pkgs.kdePackages.qtvirtualkeyboard
    (pkgs.callPackage ../../systemPackages/sddm-astronaut-theme {
      theme = "black_hole";
    })

    # For my llm fix:
    pkgs.opencode
    pkgs.hello
  ];

  # Simple NTFS mount configuration
  # fileSystems."/mnt/hdd" = {
  #   device = "/dev/disk/by-uuid/3E480BA4480B59D3";
  #   fsType = "ntfs-3g";
  #   options = [ "nofail" "rw" ];
  # };

  fileSystems."/mnt/speed" = {
    device = "/dev/disk/by-uuid/6000c312-979a-4de8-ac73-7843205fd0f2";
    fsType = "ext4";
    options = ["defaults" "noatime"];
  };

  programs = {
    xwayland = {
      enable = true;
    };
    hyprland = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  #  services.xserver.enable = true;
  #  services.xserver.displayManager.gdm.enable = true;
  #  services.desktopManager.gnome.enable = true;

  services = {
    displayManager = {
      defaultSession = "hyprland";

      sddm = {
        enable = true; # Enable SDDM.
        package = pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
        ];
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        settings = {
          Theme = {
            CursorTheme = "Bibata-Modern-Ice";
          };
        };
      };
    };
    # desktopManager.gnome.enable = true;

    xserver = {
      enable = true;
      # windowManager.gnome = {
      #   enable = true;
      #   extraPackages = with pkgs; [
      #     rofi
      #   ];
      # };
      videoDrivers = ["nvidia"];
    };
  };
  #  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics.enable = true;

    nvidia = {
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };
}
