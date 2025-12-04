{
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "envoy";
  version = "1.35.4";

  src = fetchurl {
    url = "https://github.com/BeLeap/nix-overlay/releases/download/envoy-${version}/envoy-${version}.tahoe.bottle.tar.gz";
    hash = "sha256-6HYO6FfMdCHPvyG8s1TLGbFbo14/qyZ8A2xeDf/vci8=";
  };

  unpackPhase = ''
    tar xzf $src envoy/${version}/bin/envoy
  '';

  installPhase = ''
    mkdir -p $out/bin

    cp envoy/${version}/bin/envoy $out/bin/envoy
  '';
}
