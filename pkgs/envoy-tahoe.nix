{
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "envoy";
  version = "1.35.4";

  src = fetchurl {
    url = "https://github.com/BeLeap/nix-overlay/releases/download/envoy-${version}/envoy-${version}.tahoe.bottle.tar.gz";
    hash = "";
  };

  unpackPhase = ''
    tar xzf envoy-1.35.4.tahoe.bottle.tar.gz envoy/1.35.4/bin/envoy
  '';

  installPhase = ''
    mkdir -p $out/bin

    cp envoy/${version}/bin/envoy $out/bin/envoy
  '';
}
