{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "minute";
  version = "1.12.1";

  src = fetchurl {
    url = "https://github.com/mraza007/minute/releases/download/v${finalAttrs.version}/Minute-${finalAttrs.version}-arm64.zip";
    hash = "sha256-IaqUxTG6Fw8fnAParZhypB4mzDjAvyWF6YdhjMIiYxk=";
  };

  nativeBuildInputs = [unzip];
  sourceRoot = ".";
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    # AppleDouble metadata is not part of the signed application bundle.
    find Minute.app -name '._*' -delete
    mkdir -p "$out/Applications"
    cp -R Minute.app "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Offline macOS meeting recorder, transcriber, and summarizer";
    homepage = "https://github.com/mraza007/minute";
    license = lib.licenses.mit;
    platforms = ["aarch64-darwin"];
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
})
