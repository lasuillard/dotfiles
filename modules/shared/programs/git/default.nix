{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/.gitconfig"; }
    ];

    # ~/.config/git/config
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

  home.activation = {
    # Ensure writable ~/.gitconfig file exists for overrides (such as safe.workspace settings)
    # ~/.gitconfig takes precedence over ~/.config/git/config
    createGlobalGitConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -e "''${HOME}/.gitconfig" ]; then
        touch "''${HOME}/.gitconfig"
      fi
    '';
  };
}
