# Switch kubectl-view-allocations source fetcher to fetchFromGitHub

- Replaced `fetchurl` source fetching with `fetchFromGitHub` to match nixpkgs conventions for this Rust package.
- Removed `cargoLock.lockFile = "${src}/Cargo.lock"` and switched to a pinned `cargoHash` to avoid derivation issues tied to lockfile path interpolation.
- Kept `rustPlatform.buildRustPackage` source-build approach intact (no release binary downloads).
- Added `versionCheckHook` install check for an explicit post-install binary version validation.
- Reused hashes from nixpkgs package definition for the same version (`1.1.0`) to keep package inputs deterministic.
