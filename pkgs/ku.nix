{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "ku";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "bjarneo";
    repo = "ku";
    tag = "v${version}";
    hash = "sha256-8zBTxIdKlRDlFYvnjNZvqweSVcMvIQIgSxbPVB4IlBw=";
  };

  vendorHash = "sha256-0gLwvJSEMgCw23YG8rMzoI7ubo0I5nvguex2HBJE1dU=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${version}"
  ];

  meta = {
    description = "Fast, keyboard-driven Kubernetes TUI";
    homepage = "https://github.com/bjarneo/ku";
    mainProgram = "ku";
    platforms = lib.platforms.unix;
  };
}
