{
  stdenvNoCC,
  fetchzip,
  pkgs,
  lib,
}:
let
  java = pkgs.javaPackages.compiler.temurin-bin.jre-17;
in
stdenvNoCC.mkDerivation rec {
  name = "kotlin-lsp";
  version = "261.13587.0";
  src = fetchzip {
    # origin "https://download-cdn.jetbrains.com/kotlin-lsp/{{ version }}/kotlin-lsp-{{ version }}-mac-aarch64.zip";
    url = "https://github.com/BeLeap/nix-overlay/releases/download/${name}-${version}/kotlin-lsp-${version}-mac-aarch64.zip";
    stripRoot = false;
    hash = "sha256-zwlzVt3KYN0OXKr6sI9XSijXSbTImomSTGRGa+3zCK8=";
  };

  patches = [
    ./patches/kotlin-lsp-respect-local-jre-path.patch
  ];

  nativeBuildInputs = with pkgs; [
    makeWrapper
    patchelf
    java
  ];

  installPhase = ''
    mkdir -p $out/bin

    sed -i 's/\/lib/\/..\/lib/' kotlin-lsp.sh

    install -m +x kotlin-lsp.sh $out/bin/kotlin-lsp
    mv lib $out/lib
    mv native $out/native

    wrapProgram $out/bin/kotlin-lsp \
      --prefix PATH : ${lib.makeBinPath [ java ]} \
      --set-default LOCAL_JRE_PATH ${java}
  '';

  checkPhase = ''
    kotlin-lsp --help
  '';

  meta = {
    mainProgram = "kotlin-lsp";
  };
}
