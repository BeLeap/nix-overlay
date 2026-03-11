# Parallelize Package Builds In CI

- Replaced the `nix develop --profile dev-profile -c true` CI step with explicit package builds so the workflow exercises flake package outputs instead of only materializing the dev shell.
- Removed the separate `flake-check` job and kept CI focused on package builds only.
- Added a `define-package-matrix` job that derives the package matrix from `flake.packages` with `nix eval`, keeping the workflow aligned with the package outputs the flake currently exposes on Linux and Apple Silicon macOS.
- Configured package builds to run as `nix build .#packages.<system>.<name>` with one GitHub Actions matrix entry per package, which lets GitHub build packages in parallel and push successful results to Cachix on `master`.
- Restricted the workflow triggers to `push` on `master` and `workflow_dispatch`, removing `pull_request`.
- Simplified the Cachix setup step to a single guarded action that runs only when both `CACHIX_CACHE_NAME` and `CACHIX_AUTH_TOKEN` are available.
