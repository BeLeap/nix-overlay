{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "local-transcript";
  version = "1.1.0";

  src = fetchurl {
    url = "https://github.com/gordonsph/Local-Transcript/releases/download/v${finalAttrs.version}/LocalTranscript-${finalAttrs.version}-arm64.dmg";
    hash = "sha256-QH8fL1WvczHCASm6FzJplTxuGkT5chw0/6G3OtmztMw=";
  };

  nativeBuildInputs = [undmg];
  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack
    undmg "$src"
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -R "Local Transcript.app" "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Private, on-device transcription app powered by whisper.cpp";
    homepage = "https://github.com/gordonsph/Local-Transcript";
    license = lib.licenses.mit;
    platforms = ["aarch64-darwin"];
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
})
