# Package ku

Added `ku` from `bjarneo/ku` as a Go module package.

- Version: `0.2.0`
- Upstream tag: `v0.2.0`
- Source hash: `sha256-8zBTxIdKlRDlFYvnjNZvqweSVcMvIQIgSxbPVB4IlBw=`
- Vendor hash: `sha256-0gLwvJSEMgCw23YG8rMzoI7ubo0I5nvguex2HBJE1dU=`

Notes:

- Upstream requires Go `1.26.3`; the pinned nixpkgs input already provides Go `1.26.3`.
- Upstream sets the CLI version with `-X main.version=...`; the package passes `v${version}` via `ldflags`.
- GitHub reports no declared license and the tagged source does not include a license file, so `meta.license` is intentionally unset.

Verification:

```sh
nix build .#ku
./result/bin/ku --version
```

The version check printed `ku v0.2.0`.
