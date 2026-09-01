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
    url = "https://github.com/mraza007/minute/releases/download/v${finalAttrs.version}/Minute-${finalAttrs.version}-${
      if stdenvNoCC.hostPlatform.isAarch64
      then "arm64"
      else "x86_64"
    }.zip";
    hash =
      if stdenvNoCC.hostPlatform.isAarch64
      then "sha256-IaqUxTG6Fw8fnAParZhypB4mzDjAvyWF6YdhjMIiYxk="
      else "sha256-wLj2bwUZFMTOFIt/UBcilnOyh0CG3IGo2GXuKQ6P5Ek=";
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
    platforms = lib.platforms.darwin;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
})
