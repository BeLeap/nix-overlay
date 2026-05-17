{
  lib,
  makeWrapper,
  buildGoModule,
  fetchFromGitHub,
  pinnedPkgs,
}: let
  static-tcpdump = pinnedPkgs.pkgsCross.musl64.pkgsStatic.callPackage (
    {
      lib,
      stdenv,
      fetchurl,
      libpcap,
      pkg-config,
      perl,
    }:
      stdenv.mkDerivation (finalAttrs: {
        pname = "tcpdump";
        version = "4.99.6";

        src = fetchurl {
          url = "https://www.tcpdump.org/release/tcpdump-${finalAttrs.version}.tar.gz";
          hash = "sha256-WDmSGg9n19j6PazZzUHkTInMuGfoptshbWJijH/RSwk=";
        };

        postPatch = ''
          patchShebangs tests
        '';

        nativeBuildInputs = [pkg-config];

        nativeCheckInputs = [perl];

        buildInputs = [libpcap];

        configureFlags = lib.optional (stdenv.hostPlatform != stdenv.buildPlatform) "ac_cv_linux_vers=2";

        meta = {
          description = "Network sniffer";
          homepage = "https://www.tcpdump.org/";
          license = lib.licenses.bsd3;
          maintainers = with lib.maintainers; [globin];
          platforms = lib.platforms.unix;
          mainProgram = "tcpdump";
        };
      })
  ) {};
in
  buildGoModule rec {
    pname = "kubectl-sniff";
    version = "1.6.2";

    nativeBuildInputs = [makeWrapper];

    src = fetchFromGitHub {
      owner = "eldadru";
      repo = "ksniff";
      rev = "v${version}";
      hash = "sha256-Dz+qnpUKdhNdYC74lqUZXwCk73jb6pY2tIGjtTvNiUQ=";
    };

    vendorHash = "sha256-7pSpOF8UASWqRMWaomoUBA3pD8t0qWiaIcGlXEm0Yx0=";

    doCheck = false;

    postInstall = ''
      mv $out/bin/cmd $out/bin/kubectl-sniff
      wrapProgram $out/bin/kubectl-sniff \
        --set KUBECTL_PLUGINS_LOCAL_FLAG_LOCAL_TCPDUMP_PATH ${lib.getExe static-tcpdump}
    '';
  }
