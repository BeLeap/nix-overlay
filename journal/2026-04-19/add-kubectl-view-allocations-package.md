# Add kubectl-view-allocations package

- Added `kubectl-view-allocations` to the overlay exports.
- Wired it to upstream nixpkgs (`prev.kubectl-view-allocations`) to avoid duplicating package maintenance.
- Exposed `kubectl-view-allocations` in flake `packages` outputs for all default systems.
- Could not run `nix build` locally because `nix` is not installed in this execution environment.
