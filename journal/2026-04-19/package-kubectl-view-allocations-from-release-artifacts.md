# Package kubectl-view-allocations from release artifacts

- Replaced the previous passthrough (`prev.kubectl-view-allocations`) with a local package definition because the requested package was not available in this pinned nixpkgs input.
- Added `pkgs/kubectl-view-allocations.nix` using release tarballs from `davidB/kubectl-view-allocations` version `1.1.0`.
- Included per-platform URLs and hashes for `x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, and `aarch64-darwin`.
- The derivation now throws an explicit error on unsupported systems.
- Could not run `nix`-based build checks in this environment because the `nix` CLI is not installed.
