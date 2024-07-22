{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
     
  ];

  services = {
    home-assistant = {
      enable = true;
      openFirewall = true;
      # configWritable = true;
      
      # config = {
      #   homeassistant = {
      #     name = "Home";
      #     time_zone = "Australia/Sydney";
      #     latitude = -33.0;
      #     longitude = 151.0;
      #     elevation = 1.0;
      #     unit_system = "metric";
      #     temperature_unit = "C";
      #   };
      #   # Enable the frontend
      #   frontend = { };
      #   mobile_app = { };

      #   "automation ui" = "!include automations.yaml";
      # };

      # extraComponents = [
      #   "default_config"
      #   "esphome"
      #   "zha"
      # ];
      
    };

    nginx.virtualHosts."hass.home.io" = {
      # addSSL = true;
      # enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:8123/";
        proxyWebsockets = true;
      };
    };
  };


}