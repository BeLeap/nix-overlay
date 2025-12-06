{ lib, stdenv, fetchurl, libpcap }:

stdenv.mkDerivation rec {
  pname = "pchar";
  name = pname;
  version = "1.5";

  src = fetchurl {
    url = "https://www.kitchenlab.org/www/bmah/Software/pchar/${pname}-${version}.tar.gz";
    hash = "sha256-cBkpcITxAAVXoBlQFTLsrmd3KFFxcynMAiJ/XBfjbSc=";
  };

  buildInputs = [ libpcap ];

  postPatch = ''
    mv VERSION PCHAR_VERSION

    substituteInPlace configure.in configure \
      --replace 'cat ''${srcdir}/VERSION' 'cat ''${srcdir}/PCHAR_VERSION'

    substituteInPlace Makefile.in \
      --replace 'VERSION \\\\' 'PCHAR_VERSION \\\\' \
      --replace 'version.cc: VERSION' 'version.cc: PCHAR_VERSION' \
      --replace '$(srcdir)/VERSION' '$(srcdir)/PCHAR_VERSION'

    substituteInPlace pc.h \
      --replace '#if (SIZEOF_BOOL == 0)' '#if (SIZEOF_BOOL == 0) && !defined(__cplusplus)'
  '';

  configureFlags = [
    "--with-ipv6"
    "--with-pcap=${lib.getDev libpcap}"
    "ac_cv_sizeof_bool=1"
  ];

  meta = with lib; {
    description = "Network path characterization tool";
    homepage = "https://www.kitchenlab.org/www/bmah/Software/pchar/";
    license = licenses.bsdOriginal;
    platforms = platforms.unix;
  };
}
