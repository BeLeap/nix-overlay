# Use upstream flakes for boda and kubectl-check

- Added `boda-flake` and `kubectl-check-flake` as explicit inputs in `flake.nix`.
- Split the overlay into `overlay.nix` so flake inputs can be injected directly into package wrappers.
- Replaced the local `buildRustPackage` definitions in `pkgs/boda.nix` and `pkgs/kubectl-check.nix` with thin wrappers around each upstream repository's flake package output.
- Preserved package metadata in the overlay via `overrideAttrs` so homepage, license, main program, and platform data remain available downstream.
- Kept `default.nix` as a non-flake fallback by importing `overlay.nix` with pinned `builtins.getFlake` refs.
- Verification pending via `nix flake lock --update-input boda-flake --update-input kubectl-check-flake` and `nix build .#boda .#kubectl-check`.
