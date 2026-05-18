# Add aarch64-linux QEMU CI builds

Added `aarch64-linux` package entries to the shared GitHub Actions package matrix.
The entries run on `ubuntu-latest`, matching the existing x86_64 Linux runner.

For both PR builds and Cachix publish builds, added a conditional QEMU setup step
using `docker/setup-qemu-action@v3` when `matrix.system == 'aarch64-linux'`.
The same jobs conditionally pass `extra-platforms = aarch64-linux` to
`cachix/install-nix-action@v31`, so Nix can build the aarch64 Linux package
outputs through emulation on the x86_64 Linux runner.

Validation performed:

- `nix eval` of the shared matrix expression confirmed `aarch64-linux` package
  entries are generated with `ubuntu-latest`.
- Ruby YAML parsing succeeded for all three touched workflow files.

Follow-up:

- CI still reported a Nix platform mismatch while building an `aarch64-linux`
  derivation from the x86_64 Linux runner. Added `--option extra-platforms
  aarch64-linux` directly to the `nix build` command for `aarch64-linux` matrix
  entries, so the build invocation does not rely only on install-time Nix
  configuration.
- Added a small `nix config show` diagnostic in both build workflows to surface
  `system` and `extra-platforms` in CI logs.

Second follow-up:

- `joplin-terminal` reached the emulated build phase but failed inside
  `joplin-cli`'s Yarn/Node install hook with `qemu: uncaught target signal 4
  (Illegal instruction)`. This is a QEMU execution failure, not a Nix platform
  configuration failure.
- Added an explicit `qemuUnsupportedPackages` filter in the shared matrix
  generator and excluded only `joplin-terminal` from `aarch64-linux` QEMU CI.
  The package remains in the `x86_64-linux` and `aarch64-darwin` matrix entries.
