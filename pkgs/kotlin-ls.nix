{
  stdenvNoCC,
  fetchzip,
  pkgs,
  lib,
}:
let
  runtimeDep = with pkgs; [
    javaPackages.compiler.temurin-bin.jre-17
  ];
in
stdenvNoCC.mkDerivation {
  name = "kotlin-ls";
  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/0.253.10629/kotlin-0.253.10629.zip";
    stripRoot = false;
    hash = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    patchelf
  ];

  installPhase = ''
    mkdir -p $out/bin

    sed -i 's/\/lib/\/..\/lib/' kotlin-lsp.sh

    install -m +x kotlin-lsp.sh $out/bin/kotlin-ls
    mv lib $out/lib
    mv native $out/native

    wrapProgram $out/bin/kotlin-ls \
      --prefix PATH : ${lib.makeBinPath runtimeDep}
  '';

  checkPhase = ''
    kotlin-ls --help
  '';

  meta = {
    mainProgram = "kotlin-ls";
  };
}
