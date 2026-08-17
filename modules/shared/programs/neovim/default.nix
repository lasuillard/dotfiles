{ ... }:
{
  # Configuration examples: https://nix-community.github.io/nixvim/user-guide/config-examples.html
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # https://github.com/topics/neovim-colorscheme
    colorschemes.catppuccin.enable = true;

    opts = {
      number = true;
      relativenumber = true;
    };

    editorconfig.enable = true;
    plugins = {
      lualine.enable = true;

      treesitter = {
        enable = true;
        nixvimInjections = true;

        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
  };
}
