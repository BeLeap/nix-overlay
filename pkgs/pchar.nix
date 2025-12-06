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

  configureFlags = [
    "--with-ipv6"
    "--with-pcap=${lib.getDev libpcap}"
  ];

  meta = with lib; {
    description = "Network path characterization tool";
    homepage = "https://www.kitchenlab.org/www/bmah/Software/pchar/";
    license = licenses.bsdOriginal;
    platforms = platforms.unix;
  };
}
