# Add ste package to nix-overlay

- Added `pkgs/ste.nix` with a pinned source revision and Go module hash.
- Exported `ste` through the default overlay as `pkgs.ste`.
- Exported `packages.<system>.ste` so the package enters the existing CI build matrix.
- Set the package version to `0-unstable-2026-07-29` and exposed the `ste` main program.

## Validation

- Nix parsing passed for `flake.nix`, `overlay.nix`, and `pkgs/ste.nix`. Alejandra checks passed for `flake.nix` and `pkgs/ste.nix`.
- Alejandra still reports pre-existing formatting in `overlay.nix`'s WezTerm `postFixup` block. That unrelated formatting stayed unchanged.
- The `aarch64-darwin` package build passed, including Go tests.
- Nix evaluated package derivations for `aarch64-linux`, `x86_64-linux`, and `x86_64-darwin`.
- The built CLI reported `ste 0-unstable-2026-07-29`.
