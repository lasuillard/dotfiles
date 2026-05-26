{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    bash-completion
    bind # for dnsutils
    complete-alias
    curl
    di
    htop
    jq
    lsof
    neovim
    netcat-openbsd
    nettools
    rclone
    ripgrep
    rsync
    starship
    tcpdump
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

  programs.starship = {
    enable = true;
  };

  home.file = {
    ".bashrc.d".source = ../../user/shared/.bashrc.d;
    ".bin".source = ../../user/shared/.bin;
    ".copilot".source = ../../user/shared/.copilot;
    ".gitconfig".source = ../../user/shared/.gitconfig;
    ".gitignore".source = ../../user/shared/.gitignore;
    ".gitattributes".source = ../../user/shared/.gitattributes;
    ".vimrc".source = ../../user/shared/.vimrc;
    ".bash_completion.d/complete_alias".source = "${pkgs.complete-alias}/bin/complete_alias";
    ".config/direnv" = {
      source = ../../user/shared/.config/direnv;
      recursive = true;
    };
  };
}
