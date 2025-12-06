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

    substituteInPlace Pctest.cc \
      --replace '#ifdef HAVE_BPF\n#include <sys/ioctl.h>' '#ifdef HAVE_BPF\n#include <sys/ioctl.h>\n#include <net/bpf.h>' \
      --replace 'register int sum = 0;' 'int sum = 0;' \
      --replace '        u_int immediate = 1;\n        if (ioctl(fileno, BIOCIMMEDIATE, &immediate) < 0) {\n            perror("ioctl(BIOCIMMEDIATE)");\n            exit(1);\n        }\n#endif /* HAVE_BPF */' '        u_int immediate = 1;\n#ifdef BIOCIMMEDIATE\n        if (ioctl(fileno, BIOCIMMEDIATE, &immediate) < 0) {\n            perror("ioctl(BIOCIMMEDIATE)");\n            exit(1);\n        }\n#endif\n#endif /* HAVE_BPF */'
  '';

  configureFlags = [
    "--with-ipv6"
    "--with-pcap=${lib.getDev libpcap}"
  ];

  preConfigure = ''
    export ac_cv_sizeof_bool=1
  '';

  meta = with lib; {
    description = "Network path characterization tool";
    homepage = "https://www.kitchenlab.org/www/bmah/Software/pchar/";
    license = licenses.bsdOriginal;
    platforms = platforms.unix;
  };
}
