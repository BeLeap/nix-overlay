# Build kubectl-view-allocations from source

- Replaced the binary-release-based packaging with a source build using `rustPlatform.buildRustPackage`.
- Package source is now `https://github.com/davidB/kubectl-view-allocations/archive/refs/tags/1.1.0.tar.gz` with pinned SHA256.
- Switched dependency vendoring to `cargoLock.lockFile = "${src}/Cargo.lock"` to keep lockfile-driven reproducibility without embedding release binaries.
- Kept package metadata and overlay wiring intact.
- Could not execute `nix build` in this environment because the `nix` CLI is unavailable.
