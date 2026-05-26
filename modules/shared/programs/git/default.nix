{ ... }:
{
  home.file = {
    ".config/git" = {
      source = ./.config/git;
      recursive = true;
    };
  };

  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/.gitconfig"; }
    ];
    extraConfig = {
      core = {
        excludesfile = "~/.config/git/.gitignore";
        attributesfile = "~/.config/git/.gitattributes";
      };
    };
  };
}
