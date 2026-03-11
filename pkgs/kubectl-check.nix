{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "kubectl-check";
  version = "0.2440.0";

  src = fetchFromGitHub {
    owner = "beleap";
    repo = "kubectl-check";
    tag = "v${version}";
    hash = "sha256-hAZ35ZKArHHNpiGLtOFTR1LmHT/VxaxfmhBoYgZRM6g=";
  };

  cargoHash = "sha256-mdWOD0PnYDBhGNYqKUcELr1XtKL2qafwP5lGbnYvrsI=";

  meta = with lib; {
    description = "CLI tool to prompt before potentially unsafe kubectl commands";
    homepage = "https://github.com/BeLeap/kubectl-check";
    license = licenses.mit;
    mainProgram = "kubectl-check";
    platforms = platforms.unix;
  };
}
