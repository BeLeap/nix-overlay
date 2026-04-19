{
  rustPlatform,
  fetchurl,
  lib,
}:
rustPlatform.buildRustPackage rec {
  pname = "kubectl-view-allocations";
  version = "1.1.0";

  src = fetchurl {
    url = "https://github.com/davidB/kubectl-view-allocations/archive/refs/tags/${version}.tar.gz";
    hash = "sha256-aLr43W179E5uACnDTIOFa1+PrG7IP5a/lF5UkCVNIpY=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  meta = with lib; {
    description = "kubectl plugin to list allocations and utilization metrics";
    homepage = "https://github.com/davidB/kubectl-view-allocations";
    license = licenses.cc0;
    mainProgram = "kubectl-view-allocations";
  };
}
