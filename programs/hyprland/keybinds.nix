{
  config,
  pkgs,
  inputs,
  ...
}: let
  mod = "ALT";
in {
  # Configuration stuff ...
  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "${mod}, RETURN, exec, $terminal"
        "${mod}, Q, killactive"
        "${mod}, D, exec, noctalia-shell ipc call launcher toggle"

        # Regular number key workspace navigation
        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"
        "${mod}, 0, workspace, 10"

        # Numpad workspace navigation
        "${mod}, XKB_KP_1, workspace, 1"
        "${mod}, XKB_KP_2, workspace, 2"
        "${mod}, XKB_KP_3, workspace, 3"
        "${mod}, XKB_KP_4, workspace, 4"
        "${mod}, XKB_KP_7, workspace, 7"
        "${mod}, XKB_KP_8, workspace, 8"
        "${mod}, XKB_KP_9, workspace, 9"
        "${mod}, XKB_KP_0, workspace, 10"

        # Numpad move window to workspace
        "${mod} SHIFT, KP_1, movetoworkspace, 1"
        "${mod} SHIFT, KP_2, movetoworkspace, 2"
        "${mod} SHIFT, KP_3, movetoworkspace, 3"
        "${mod} SHIFT, KP_4, movetoworkspace, 4"
        "${mod} SHIFT, KP_5, movetoworkspace, 5"
        "${mod} SHIFT, KP_6, movetoworkspace, 6"
        "${mod} SHIFT, KP_7, movetoworkspace, 7"
        "${mod} SHIFT, KP_8, movetoworkspace, 8"
        "${mod} SHIFT, KP_9, movetoworkspace, 9"
        "${mod} SHIFT, KP_0, movetoworkspace, 10"
      ];
    };
  };
}
