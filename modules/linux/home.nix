{
  username,
  pkgs,
  ...
}:
{
  home.username = username;
  home.homeDirectory = if username == "root" then "/root" else "/home/${username}";
  home.packages = with pkgs; [
    # TCP/IP swiss army knife (OpenBSD variant): https://salsa.debian.org/debian/netcat-openbsd
    netcat-openbsd
    # sysstat: https://sysstat.github.io/
    # iostat - reports CPU statistics and input/output statistics for block devices and partitions
    # cifsiostat - reports CIFS statistics.
    # mpstat - reports individual or combined processor related statistics
    # pidstat - reports statistics for Linux tasks (processes) : I/O, CPU, memory, etc.
    # sadf - displays data collected by sar in multiple formats (CSV, XML, JSON, etc.) and can be used for data exchange with other programs.
    #        This command can also be used to draw graphs for the various activities collected by sar using SVG (Scalable Vector Graphics) format.
    # sar - collects, reports and saves system activity information (see below a list of metrics collected by sar).
    # tapestat - reports statistics for tape drives connected to the system.
    sysstat
  ];

  imports = [
    ../shared/programs/antigravity-cli
    ../shared/programs/bash
    # ../shared/programs/claude-code
    # ../shared/programs/codex-cli
    ../shared/programs/direnv
    ../shared/programs/git
    # ../shared/programs/github-copilot-cli
    # ../shared/programs/kilo
    ../shared/programs/neovim
    ../shared/programs/nix
    ../shared/programs/starship
    ../shared/programs/tailscale
    ../shared/programs/tmux
    ../shared/packages.nix
  ];
}
