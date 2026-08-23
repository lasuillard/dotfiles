{
  pkgs,
  llm-agents,
  config,
  lib,
  ...
}:
let
  currentDir = ./.;
in
{
  home.packages = with pkgs; [
    jq
    # Antigravity CLI: https://antigravity.google/product/antigravity-cli
    llm-agents.antigravity-cli
  ];

  # Provision files read-only (don't want to be edited)
  home.file = {
    ".gemini/GEMINI.md".source = ./.gemini/GEMINI.md;
  };

  home.activation = {
    # Provision files in editable manner
    initAntigravityConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      target_dir="''${HOME}/.gemini/antigravity-cli"
      if [ ! -d "$target_dir" ]; then
        mkdir --parents "$target_dir"
        chmod 755 "$target_dir"

        # Copy the contents of the source directory to the target directory
        cp --recursive --no-target-directory "${currentDir}/.gemini/antigravity-cli" "$target_dir"
        find "$target_dir" -type d -exec chmod 755 {} +
        find "$target_dir" -type f -exec chmod 644 {} +

        # Grant execute permission to customization scripts
        chmod +x "''${target_dir}/title.sh"
        chmod +x "''${target_dir}/statusline.sh"
      fi
    '';
  };
}
