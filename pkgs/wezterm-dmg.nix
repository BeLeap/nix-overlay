{
  stdenv,
  fetchurl,
  unzip,
  ...
}:
stdenv.mkDerivation {
  pname = "wezterm";
  version = "20240203-110809-5046fc22";

  src = fetchurl {
    url = "https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-macos-20240203-110809-5046fc22.zip";
    hash = "sha256-53OIytVfLp2pWiIKiSBqbFj4ZYdKYpt8PqPBYvVpIiQ=";
  };
  sourceRoot = ".";

  nativeBuildInputs = [unzip];

  unpackPhase = ''
    runHook preUnpack
    unzip "$src"
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    mkdir -p $out/bin
    cp -R WezTerm-macos-20240203-110809-5046fc22/WezTerm.app $out/Applications/
    for bin in wezterm wezterm-gui wezterm-mux-server; do
      ln -s $out/Applications/WezTerm.app/Contents/MacOS/$bin $out/bin/$bin
    done
    runHook postInstall
  '';

  meta.platforms = [
    "aarch64-darwin"
  ];
}
