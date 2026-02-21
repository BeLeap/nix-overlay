{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "pchar";
  version = "1.5";

  src = fetchurl {
    url = "https://www.kitchenlab.org/www/bmah/Software/pchar/pchar-${version}.tar.gz";
    hash = "sha256-cBkpcITxAAVXoBlQFTLsrmd3KFFxcynMAiJ/XBfjbSc=";
  };

  configureFlags = [
    # pchar's IPv6 code does not compile on modern Darwin SDKs.
    "--without-ipv6"
  ];

  # Old autoconf logic mis-detects bool on modern toolchains.
  preConfigure = ''
    export ac_cv_sizeof_bool=1
  '';

  postPatch = ''
    # Avoid <version> C++ header collision with local VERSION on case-insensitive filesystems.
    substituteInPlace Makefile.in \
      --replace-fail 'IFLAGS=@CPPFLAGS@ -I$(srcdir)' 'IFLAGS=@CPPFLAGS@'

    # Resolve stdlib abs overload ambiguity in modern C++.
    substituteInPlace ResultTable.cc \
      --replace-fail 'residuals[l] = abs(partialmins[i] - ' 'residuals[l] = fabs(partialmins[i] - ' \
      --replace-fail 'ys[l] = abs(partialmins[i] - mediany);' 'ys[l] = fabs(partialmins[i] - mediany);'
  '';

  env.NIX_CFLAGS_COMPILE = "-std=gnu++98";

  installPhase = ''
    runHook preInstall
    install -Dm755 pchar $out/bin/pchar
    install -Dm644 pchar.8 $out/share/man/man8/pchar.8
    runHook postInstall
  '';

  meta = with lib; {
    description = "Measure bandwidth, latency, and loss along an Internet path";
    homepage = "https://www.kitchenlab.org/www/bmah/Software/pchar/";
    license = licenses.unfree;
    platforms = platforms.unix;
    mainProgram = "pchar";
  };
}
