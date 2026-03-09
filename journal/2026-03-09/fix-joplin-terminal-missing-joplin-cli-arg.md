# Fix joplin-terminal missing joplin-cli argument

## Context
`nix` evaluation failed with:

```
lib.customisation.callPackageWith: Function called without required argument "joplin-cli"
```

Source: `pkgs/joplin-terminal/default.nix` expected `{ joplin-cli }`, but nixpkgs for this flake exposes `joplin` (and not `joplin-cli`).

## Investigation
Checked attribute availability against flake nixpkgs input:

- `hasAttr "joplin-cli" pkgs` -> `false`
- `hasAttr "joplin" pkgs` -> `true`

## Change
Updated package argument in `pkgs/joplin-terminal/default.nix`:

- before: `{ joplin-cli }: joplin-cli.overrideAttrs ...`
- after: `{ joplin }: joplin.overrideAttrs ...`

Kept the existing `postInstall` repair logic unchanged.

## Validation
- `nix eval .#devShells.x86_64-darwin.default.drvPath` now passes the previous argument-resolution point.
- Plain eval fails later because upstream `joplin` is marked broken in nixpkgs.
- Confirmed full derivation resolution with:

```bash
NIXPKGS_ALLOW_BROKEN=1 nix eval --impure .#devShells.x86_64-darwin.default.drvPath
```

Result:

```
"/nix/store/qii4v05cfkbswr6gvvpsl32yh93ayrqw-nix-shell.drv"
```

## Follow-up note
`nh search joplin-cli` on current `nixos-unstable` does show `joplin-cli` (3.5.1).

This flake is pinned to nixpkgs rev `b3d51a0365f6695e7dd5cdf3e180604530ed33b4`, where top-level `joplin-cli` is not present, but `joplin` is.

Overlay wiring was updated to keep `pkgs/joplin-terminal/default.nix` on `{ joplin-cli }` while passing:

- `prev.joplin-cli` when available
- otherwise `prev.joplin`
