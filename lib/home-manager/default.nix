{ ... }:
{
  imports = [
    # List library modules here for export
    ./programs/example
  ];

  home.file = {
    ".copilot".source = ../../user/shared/.copilot;
  };
}
