{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/.gitconfig"; }
    ];
    settings = {
      core = {
        excludesfile = "~/.config/git/.gitignore";
        attributesfile = "~/.config/git/.gitattributes";
      };
    };
  };

  home.packages = with pkgs; [
    # Source control system: https://git-scm.com/
    git
    # GitHub CLI: https://cli.github.com/
    gh
  ];

  home.file = {
    ".config/git" = {
      source = ./.config/git;
      recursive = true;
    };
  };
}
