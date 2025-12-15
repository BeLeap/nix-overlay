{
  stdenv,
  fetchurl,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "kdeconnect";
  name = pname;
  version = "5612";

  src = fetchurl {
    url = "https://github.com/BeLeap/nix-overlay/releases/download/${pname}-${version}/${pname}-${version}.dmg";
    sha256 = "73cc58f6d5384ce6e8feebcd059bf5294ebda36949ff06feea12de17ef7f816f";
  };

  nativeBuildInputs = [ pkgs.undmg ];

  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack
    undmg "$src"
    # (선택) 무슨 .app이 나왔는지 로그
    echo "Apps: " *.app || true
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    # DMG 안의 모든 .app을 복사 (하나만 있으면 하나만 복사됨)
    cp -R *.app $out/Applications/
    runHook postInstall
  '';

  meta.platforms = [
    "aarch64-darwin"
  ];
}
