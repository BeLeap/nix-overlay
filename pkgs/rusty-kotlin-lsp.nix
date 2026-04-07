{
  pkgs,
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "rusty-kotlin-lsp";
  name = pname;
  version = "0.2.1";
  src = fetchFromGitHub {
    owner = "Hessesian";
    repo = "kotlin-lsp";
    rev = "b0281d3306491f4644d6014a381dcb7907d1afee";
    hash = "sha256-zEe/q/ADwwfRqed/Gf7LUlyHQvWNzMMIlDwgyv5QJ64=";
  };
  cargoHash = "sha256-WBABvB/hbbNILLh7sRH2nSt9ubkaeVBDw7ZJFRcM2MY=";

  nativeBuildInputs = with pkgs; [
    makeWrapper

    fd
    ripgrep
  ];

  postFixup = ''
    wrapProgram $out/bin/kotlin-lsp \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [fd ripgrep])}
  '';

  meta = {
    mainProgram = "kotlin-lsp";
  };
}
