{
  lib,
  stdenv,
  fetchurl,
  installShellFiles,
  ...
}:
let
  version = "2.10.3";

  assetMap = {
    "x86_64-linux" = {
      url = "https://github.com/satococoa/wtp/releases/download/v${version}/wtp_${version}_Linux_x86_64.tar.gz";
      hash = "sha256:8383e3129d1cf33b74687c0f671f863e08ea69a34c6313456dcee52bbf2ab40a";
    };
    "aarch64-linux" = {
      url = "https://github.com/satococoa/wtp/releases/download/v${version}/wtp_${version}_Linux_arm64.tar.gz";
      hash = "sha256:224ea5d829fd05bd6e31f51aec912ff8126bd87b85f0102a25cefdcc8078c9e2";
    };
    "aarch64-darwin" = {
      url = "https://github.com/satococoa/wtp/releases/download/v${version}/wtp_${version}_Darwin_arm64.tar.gz";
      hash = "sha256:8a60b52bf5aae55633283cf5a441fe9284084c0b0061f79d598a79cd62f2e1a6";
    };
  };

  currentSystem = stdenv.hostPlatform.system;
  matchingAsset = assetMap.${currentSystem} or (throw "Unsupported system: ${currentSystem}");
in
stdenv.mkDerivation rec {
  inherit version;

  pname = "wtp";

  src = fetchurl {
    url = matchingAsset.url;
    hash = matchingAsset.hash;
  };

  sourceRoot = ".";

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    runHook preInstall

    mkdir --parents "''${out}/bin"
    cp wtp "''${out}/bin/wtp"
    chmod +x "''${out}/bin/wtp"

    installShellCompletion --cmd wtp \
      --bash <($out/bin/wtp hook bash) \
      --fish <($out/bin/wtp hook fish) \
      --zsh <($out/bin/wtp hook zsh)

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/satococoa/wtp";
    description = "🌳 A powerful Git worktree CLI tool with automated setup, branch tracking, and smart navigation";
    changelog = "https://github.com/satococoa/wtp/releases/tag/v${version}";
    license = "mit";
    mainProgram = "wtp";
  };
}
