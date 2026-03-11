{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "boda";
  version = "0.2526.0";

  src = fetchFromGitHub {
    owner = "beleap";
    repo = "boda";
    tag = version;
    hash = "sha256-NS0p7W2nyrKEQ17Cc9JrW002hPi1zVXIBwzXGBz2WNk=";
  };

  cargoHash = "sha256-gAb1lnA2iF3032T/DzhVxdyfvdBllPOVygIbhJbdW/A=";

  meta = with lib; {
    description = "Opinionated alternative to watch";
    homepage = "https://github.com/BeLeap/boda";
    license = licenses.mit;
    mainProgram = "boda";
    platforms = platforms.unix;
  };
}
