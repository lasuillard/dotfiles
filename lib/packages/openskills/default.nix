{ pkgs, ... }:
let

in
pkgs.buildNpmPackage rec {
  pname = "openskills";
  version = "1.5.0";

  src = pkgs.fetchFromGitHub {
    owner = "numman-ali";
    repo = "openskills";
    rev = "v${version}";
    hash = "sha256-rOrLi43J+w6XBRZYYwlDPl8RqU7Zhr45B9UyP6Xarj0=";
  };

  npmDepsHash = "sha256-3ESEmIuCw/zdTW92Y7tJlRs5sKnu2+7O9HkeX9aKfS4=";

  meta = {
    changelog = "https://github.com/vercel-labs/skills/releases/tag/v${version}";
    description = "The open agent skills tool";
    homepage = "https://github.com/vercel-labs/skills";
    mainProgram = "openskills";
  };
}
