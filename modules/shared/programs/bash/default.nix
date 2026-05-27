{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    bash-completion
    complete-alias
  ];

  home.file = {
    ".bash_completion.d/complete_alias".source = "${pkgs.complete-alias}/bin/complete_alias";
    ".bin/shell" = {
      source = ./.bin/shell;
      recursive = true;
    };
    ".bashrc.d".source = ./.bashrc.d;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.bin/shell"
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      # Workaround for nix not being available in the PATH when using bash as the login shell
      # e.g. in Docker containers (single-user installation)
      if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi

      # Source .bashrc.d files
      if [ -d "$HOME/.bashrc.d" ]; then
        for file in "$HOME/.bashrc.d"/*.sh; do
          [ -r "$file" ] && source "$file"
        done
      fi
    '';
  };
}
