{
  lib,
  rustPlatform,
  fetchFromGitHub,
  apple-sdk_15,
  swift,
  swiftpm,
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

  cargoHash = "sha256-ORn2xiyanQgHeCol1+fDc+Ua9PbvApMg7FZIFn658E0=";

  # screencapturekit builds its Swift bridge with `swift build`. Keep Cargo in
  # charge of the Rust build instead of allowing SwiftPM's setup hook to
  # replace the build and check phases.
  dontUseSwiftpmBuild = true;
  dontUseSwiftpmCheck = true;

  nativeBuildInputs = [
    swift
    swiftpm
  ];

  buildInputs = [ apple-sdk_15 ];

  meta = {
    description = "Inspect macOS accessibility hierarchies from the terminal";
    homepage = "https://github.com/watzon/ax-cli";
    license = lib.licenses.mit;
    mainProgram = "ax";
    platforms = lib.platforms.darwin;
  };
}
