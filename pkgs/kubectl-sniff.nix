{
  stdenvNoCC,
  fetchurl,
  stdenv,
  pkgs,
}:
let
  mapping = {
    "aarch64-darwin" = "kubectl-sniff-darwin-arm64";
    "x86_64-darwin" = "kubectl-sniff-darwin";
    "x86_64-linux" = "kubectl-sniff";
  };
  binary = mapping.${stdenv.hostPlatform.system};
in
stdenvNoCC.mkDerivation rec {
  pname = "kubectl-sniff";
  version = "1.6.2";

  nativeBuildInputs = with pkgs; [
    unzip
  ];

  src = fetchurl {
    url = "https://github.com/eldadru/ksniff/releases/download/v${version}/ksniff.zip";
    hash = "sha256-xZtcnqhNbLdxCW8SRskZtxOJ+dQjToWPSSkgiVflYf0=";
  };

  unpackPhase = ''
    runHook preUnpack
    unzip $src
    ls -alR || true
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 ${binary} $out/bin/kubectl-sniff
    install -m755 static-tcpdump $out/bin/static-tcpdump

    runHook postInstall
  '';

  dontBuild = true;
}
