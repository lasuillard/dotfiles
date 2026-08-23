{ ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
  };

  home.file = {
    ".tmux.conf".source = ./.tmux.conf;
  };
}
