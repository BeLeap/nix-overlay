{
  lib,
  stdenv,
  fetchurl,
  unzip,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "keeping-you-awake";
  version = "1.6.8";

  src = fetchurl {
    url = "https://github.com/newmarcel/KeepingYouAwake/releases/download/${finalAttrs.version}/KeepingYouAwake-${finalAttrs.version}.zip";
    hash = "sha256-gAGhSbRJDACP2sGYmLzpkC1RbEqmQSp+sPmjdEOxXGs=";
  };

  nativeBuildInputs = [unzip];
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    cp -R KeepingYouAwake.app "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Prevent your Mac from going to sleep";
    homepage = "https://github.com/newmarcel/KeepingYouAwake";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
})
