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
      #   # Includes dependencies for a basic setup
      #   # https://www.home-assistant.io/integrations/default_config/
      #   default_config = {};
      # };

      
      config = {
        default_config = {};
        # homeassistant = {
        #   name = "Home";
        #   time_zone = "Australia/Sydney";
        #   latitude = -33.0;
        #   longitude = 151.0;
        #   elevation = 1.0;
        #   unit_system = "metric";
        #   temperature_unit = "C";
        # };
        # # Enable the frontend
        # frontend = { };
        http = {
          server_host = "::1";
          trusted_proxies = [ "::1" ];
          use_x_forwarded_for = true;
        };

        # "automation ui" = "!include automations.yaml";
      };

      extraComponents = [
        "default_config"
        "esphome"
        "met"
        "radio_browser"
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