{
  lib,
  stdenvNoCC,
  fetchurl,
  installFonts,
  unzip,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "monoplex-kr-nerd";
  version = "0.0.2";

  src = fetchurl {
    url = "https://github.com/y-kim/monoplex/releases/download/v${finalAttrs.version}/MonoplexKR-v${finalAttrs.version}.zip";
    hash = "sha256-F0/CPyvhXvbU2BisRpBz8uUS2WHSOO0qzsDDN1/lroE=";
  };

  nativeBuildInputs = [
    installFonts
    unzip
  ];
  sourceRoot = "MonoplexKRNerd";

  meta = {
    description = "Monospace Korean programming font patched with Nerd Fonts symbols";
    homepage = "https://github.com/y-kim/monoplex";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
})
