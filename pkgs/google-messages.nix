{
  stdenv,
  fetchurl,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "google-messages";
  name = pname;
  version = "20260325";

  src = fetchurl {
    url = "https://github.com/BeLeap/nix-overlay/releases/download/${pname}-${version}/Messages.dmg";
    hash = "sha256-Xml5BpjVa4vbc8M6SlvKgfglZ6j3R7+bswDZPYUwtpE=";
  };

  nativeBuildInputs = [pkgs.undmg];

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
