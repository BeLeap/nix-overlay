{
  pkgs,
  lib,
  rustPlatform,
  stdenv,
  fetchFromGitHub,
  fetchurl,
}:
let
  jarIndexerAssets = {
    "aarch64-darwin" = {
      name = "darwin-aarch64";
      hash = "sha256-Z2bJWEoNiW1xyVovnk7RvwNsA5LmaG3Q97HK16XG+cg=";
    };
    "x86_64-darwin" = {
      name = "darwin-x86_64";
      hash = "sha256-Z2bJWEoNiW1xyVovnk7RvwNsA5LmaG3Q97HK16XG+cg=";
    };
    "aarch64-linux" = {
      name = "linux-aarch64";
      hash = "sha256-frMDnlE2h9Sed5QvHnDDR1aBErnj5pi84/EZTDz1KpQ=";
    };
    "x86_64-linux" = {
      name = "linux-x86_64";
      hash = "sha256-BrBqUF1LAsqjKzWRT79XWWcaTI0KOgLOCvTDhCFRIRE=";
    };
  };
  jarIndexerAsset = jarIndexerAssets.${stdenv.hostPlatform.system};
  jarIndexer = fetchurl {
    url = "https://github.com/Hessesian/kmp-lsp/releases/download/v0.26.0/kmp-jar-indexer-${jarIndexerAsset.name}.gz";
    hash = jarIndexerAsset.hash;
  };
in
rustPlatform.buildRustPackage rec {
  pname = "kmp-lsp";
  version = "0.26.0";
  src = fetchFromGitHub {
    owner = "Hessesian";
    repo = "kmp-lsp";
    rev = "v${version}";
    hash = "sha256-Xz3PLhBvBLRBd+h5/r8wHab7fxT63pRoxiKKrNf1ZiY=";
  };
  cargoHash = "sha256-ibXqbMu3VRRhwjeaR8QAuaBLFfluc3X0bWPRtoFdyP0=";

  nativeBuildInputs = with pkgs; [
    makeWrapper
    gzip

    fd
    ripgrep
  ];

  preCheck = ''
    gzip -dc ${jarIndexer} > kmp-jar-indexer
    chmod +x kmp-jar-indexer
    while IFS= read -r -d "" binary; do
      install -m 755 kmp-jar-indexer "$(dirname "$binary")/kmp-jar-indexer"
    done < <(find target -type f -name kmp-lsp -print0)
  '';

  postInstall = ''
    gzip -dc ${jarIndexer} > $out/bin/kmp-jar-indexer
    chmod +x $out/bin/kmp-jar-indexer
  '';

  postFixup = ''
    wrapProgram $out/bin/kmp-lsp \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [fd ripgrep])}
  '';

  meta = {
    mainProgram = "kmp-lsp";
  };
}
