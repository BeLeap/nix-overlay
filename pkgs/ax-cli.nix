{
  lib,
  rustPlatform,
  fetchFromGitHub,
  swiftPackages,
  appleSdk,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "ax-cli";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "watzon";
    repo = "ax-cli";
    rev = "v${finalAttrs.version}";
    hash = "sha256-OOVU/H03T52uvrpgnjjw10xZWR9cx7r+h1IN+YBRyfM=";
  };

  cargoHash = "sha256-ORn2xiyanQgHeCol1+fDc+Ua9PbvApMg7FZIFn658E0=";

  nativeBuildInputs = [
    swiftPackages.swift
    swiftPackages.swiftpm
  ];

  dontUseSwiftpmBuild = true;
  dontUseSwiftpmCheck = true;

  NIX_LDFLAGS = "-L${appleSdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/swift";

  meta = {
    description = "macOS Accessibility Inspector CLI";
    homepage = "https://github.com/watzon/ax-cli";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    mainProgram = "ax";
  };
})
