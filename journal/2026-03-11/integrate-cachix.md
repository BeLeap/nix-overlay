# Integrate Cachix

- Chose GitHub Actions as the only Cachix push path; no local push helper is kept in the flake.
- Added a matrix workflow that installs Nix, configures Cachix, runs `nix flake check`, and builds the dev shell profile on Linux and macOS.
- Configured the workflow to use pull-only cache access on pull requests and push access on `master` when `CACHIX_AUTH_TOKEN` is present.
- Restricted the `kdeconnect-mac` flake check to `aarch64-darwin` so Linux CI runners do not evaluate a macOS-only derivation.
- Kept only the binary-cache consumption snippet in `README.md`, without extra CI setup documentation.
- Added the `beleap-nix-overlay` Cachix `nixConfig` directly to `flake.nix`.
