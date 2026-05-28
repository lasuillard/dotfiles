{ pkgs, config, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = false; # We'll do it ourselves
    initExtra = ''
      export PATH="''${HOME}/.bin/shell''${PATH:+:}''${PATH}"

      # Workaround for nix not being available in the PATH when using bash as the login shell
      # e.g. in Docker containers (single-user installation)
      if [ -e "''${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
        source "''${HOME}/.nix-profile/etc/profile.d/nix.sh"
      fi

      # Source .bashrc.d files
      if [ -d "''${HOME}/.bashrc.d" ]; then
        for file in "''${HOME}/.bashrc.d"/*.sh; do
          [ -r "''${file}" ] && source "''${file}"
        done
      fi
    '';
  };

  home.packages = with pkgs; [
    # Programmable completion for the bash shell: https://github.com/scop/bash-completion
    bash-completion
    # Auto-completion for aliases: https://github.com/cykerway/complete-alias
    complete-alias
  ];

  home.file = {
    ".bash_completion.d/complete_alias".source = "${pkgs.complete-alias}/bin/complete_alias";
    ".bin/shell".source = ./.bin/shell;
    ".bashrc.d".source = ./.bashrc.d;
  };

  # NOTE: Extra PATH listed in home.sessionPath will be populated on shell LOGIN (~/.profile)
  home.sessionPath = [
    # "${config.home.homeDirectory}/.bin/shell"
  ];
}
