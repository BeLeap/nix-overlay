# Speed up aarch64 Linux CI

Changed the shared package matrix so `aarch64-linux` builds run on GitHub's
native `ubuntu-24.04-arm` hosted runner instead of `ubuntu-latest` with QEMU.

Removed the QEMU setup and `extra-platforms` handling from both package build
workflows. Native runner selection is now represented only by the matrix `os`
field, which keeps the workflow simpler.

Kept `joplin-terminal` excluded from `aarch64-linux` CI for now. Its earlier
failure was observed under QEMU, and native arm64 validation should be handled as
a separate change before re-enabling it.

Validation:

- `nix eval --json --impure --file scripts/define-package-matrix.nix` succeeds
  and emits `ubuntu-24.04-arm` for `aarch64-linux` packages, including
  `kubectl-sniff`.
- Ruby YAML parsing succeeds for all workflows in `.github/workflows`.
