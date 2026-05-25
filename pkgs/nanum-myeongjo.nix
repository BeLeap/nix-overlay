{
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation {
  name = "nanum-myeongjo";
  dontUnpack = true;
  src = fetchurl {
    url = "https://hangeul.pstatic.net/hangeul_static/webfont/NanumMyeongjo/NanumMyeongjo.ttf";
    hash = "sha256-60qd4wIu0nRMBipMRTMuh3FUYr9y817cNP6EUptKwT0=";
  };
  installPhase = ''
    runHook preInstall
    install -Dm644 $src $out/share/fonts/truetype/NanumMyeongjo.ttf
    runHook postInstall
  '';
  meta = {
    description = "Nanum Myeongjo font";
    platforms = lib.platforms.all;
  };
}
