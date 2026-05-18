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
