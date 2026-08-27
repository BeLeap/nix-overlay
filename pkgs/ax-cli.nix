{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "ax-cli";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "watzon";
    repo = "ax-cli";
    tag = "v${version}";
    hash = "sha256-OOVU/H03T52uvrpgnjjw10xZWR9cx7r+h1IN+YBRyfM=";
  };

  cargoHash = "sha256-MTZCA266g2pgCl13e8AIrNc9D0aDvmfQMBtEyI/xVSc=";

  meta = {
    description = "Inspect macOS accessibility hierarchies from the terminal";
    homepage = "https://github.com/watzon/ax-cli";
    license = lib.licenses.mit;
    mainProgram = "ax";
    platforms = lib.platforms.darwin;
  };
}
