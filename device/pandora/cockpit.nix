{...}:
{

  environment.systemPackages = with pkgs; [
     cockpit # cockpit
  ];

    services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };


}