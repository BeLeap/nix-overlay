{
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation {
  name = "nanum-myeongjo";
  dontConfigue = true;
  dontUnpack = true;
  src = fetchurl {
    url = "https://hangeul.pstatic.net/hangeul_static/webfont/NanumMyeongjo/NanumMyeongjo.ttf";
    hash = "sha256-60qd4wIu0nRMBipMRTMuh3FUYr9y817cNP6EUptKwT0=";
  };
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/
  '';
}
