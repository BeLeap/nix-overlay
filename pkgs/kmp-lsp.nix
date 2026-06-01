{
  pkgs,
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "kmp-lsp";
  version = "0.20.0";
  src = fetchFromGitHub {
    owner = "Hessesian";
    repo = "kotlin-lsp";
    rev = "v${version}";
    hash = "sha256-78ooVOoySdMZAhgpDJZjqEaOEIzSPZ1mC2M79OSCt4o=";
  };
  cargoHash = "sha256-28SAdHRlOMyMgPfYzYtjfqPDCcei4uPk0X/mc4SIeYM=";

  nativeBuildInputs = with pkgs; [
    makeWrapper

    fd
    ripgrep
  ];

  postFixup = ''
    wrapProgram $out/bin/kmp-lsp \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [fd ripgrep])}
  '';

  meta = {
    mainProgram = "kmp-lsp";
  };
}
