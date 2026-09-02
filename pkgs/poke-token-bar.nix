{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "poke-token-bar";
  version = "2.5.3";

  src = fetchurl {
    url = "https://github.com/chattymin/PokeTokenBar/releases/download/v${finalAttrs.version}/PokeTokenBar.zip";
    hash = "sha256-qNYNKCgqDjhaIoHSil2xwRV2wWKYOTYnKROEQF1Ym+I=";
  };

  nativeBuildInputs = [unzip];
  sourceRoot = ".";
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    # The release archive contains macOS metadata files which are not part of
    # the signed app bundle and make codesign verification fail after unzip.
    find PokeTokenBar.app -name '._*' -delete
    mkdir -p "$out/Applications"
    cp -R PokeTokenBar.app "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Track AI coding token usage with a Pokémon companion in the macOS menu bar";
    homepage = "https://github.com/chattymin/PokeTokenBar";
    license = lib.licenses.mit;
    platforms = ["aarch64-darwin"];
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
})
