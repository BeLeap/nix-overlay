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
    hash = "sha256-r2xny76NtvIi9zCs0JKdpiCglFbJlzf7eFL4iBGrdAc=";
  };
  cargoHash = "sha256-lViQHU33YeNl8K6UV83fhHCiCO11ppSzUgzKc0ruwu4=";

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
