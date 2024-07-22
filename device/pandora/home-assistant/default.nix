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
      
      config = {
        homeassistant = {
          name = "Home";
          time_zone = "Australia/Sydney";
          latitude = -33;
          longitude = 151;
          elevation = 1;
          unit_system = "metric";
          temperature_unit = "C";
        };
        # Enable the frontend
        frontend = { };
        mobile_app = { };
      };

      extraComponents = [
        "default_config"
        "esphome"
        "zha"
      ];
      
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