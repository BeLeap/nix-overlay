# Integrate Cachix

- Chose GitHub Actions as the only Cachix push path; no local push helper is kept in the flake.
- Added a workflow that installs Nix, configures Cachix, runs `nix flake check`, and builds the dev shell profile.
- Configured the workflow to use pull-only cache access on pull requests and push access on `master` when `CACHIX_AUTH_TOKEN` is present.
- Updated `README.md` with the required repository variable and secret.
- Documented the concrete `nixConfig` snippet for the `beleap-nix-overlay` cache, including its public signing key.
