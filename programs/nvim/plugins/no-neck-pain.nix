{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      no-neck-pain-nvim
    ];

    extraConfigLua = ''
      require'no-neck-pain'.setup {
          buffers = {
              right = {
                  enabled = false,
              },
              scratchPad = {
                  enabled = true,
                  location = "~/",
              },
              bo = {
                  filetype = "md",
              },
          },
          autocmds = {
              enableOnVimEnter = true,
              reloadOnColorSchemeChange = true,
          },
      }'';

    keymaps = [
      {
        key = "<leader>n";
        action = ":NoNeckPain<CR>";
        options = {
          silent = true;
          desc = "Toggle NoNeckPain";
        };
      }
    ];
  };
}
