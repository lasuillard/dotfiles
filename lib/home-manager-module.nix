{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    bash-completion
    curl
    di
    bind # for dnsutils
    htop
    jq
    lsof
    nettools
    netcat-openbsd
    rclone
    rsync
    tcpdump
    vim
    complete-alias
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Source .bashrc.d files
      if [ -d ~/.bashrc.d ]; then
        for file in ~/.bashrc.d/*.bash; do
          [ -r "$file" ] && . "$file"
        done
      fi
    '';
  };

  home.file = {
    ".bashrc.d".source = ../modules/shared/.bashrc.d;
    ".bin".source = ../modules/shared/.bin;
    ".copilot".source = ../modules/shared/.copilot;
    ".gitconfig".source = ../modules/shared/.gitconfig;
    ".gitignore".source = ../modules/shared/.gitignore;
    ".gitattributes".source = ../modules/shared/.gitattributes;
    ".vimrc".source = ../modules/shared/.vimrc;
    ".bash_completion.d/complete_alias".source = "${pkgs.complete-alias}/bin/complete_alias";
    # TODO: Disabled direnv symlinks due to conflicts with nix-direnv; consider re-enabling with adjustments
    # ".config/direnv/lib".source = ../modules/shared/.config/direnv/lib;
    # ".config/direnv/direnv.toml".source = ../modules/shared/.config/direnv/direnv.toml;
  };
}
