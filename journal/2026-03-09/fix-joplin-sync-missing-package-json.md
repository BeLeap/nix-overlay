# Fix joplin sync missing package.json

## Context
Running `joplin sync` failed immediately with:

```
Cannot find module './package.json'
Require stack:
- /nix/store/5j2659vv1y08lcrvpy851xh0dw0s9hb6-joplin-cli-3.5.1/lib/packages/app-cli/app/main.js
```

## Root cause
`joplin-cli` install phase removes `*.json` files under `lib/packages/app-cli`:

- `rm -rf $out/lib/packages/app-cli/{app/*.test.ts,*.md,.*ignore,tests/,tools/,*.js,*.json,*.sh}`

This also deletes `lib/packages/app-cli/app/package.json`, but runtime code in `app/main.js` calls `require('./package.json')` for `appVersion()`.

## Fix
Added a local overlay override for `joplin-cli` in `default.nix`.

- Appends a `postInstall` step.
- Recreates `lib/packages/app-cli/app/package.json` if missing.
- Sets JSON content to `{"version":"<derivation version>"}`.

## Validation performed
- Reproduced failure with current profile: `joplin sync` fails with missing `./package.json`.
- Updated overlay so resulting derivation includes a `postInstall` repair step.

## Remaining validation
A full `nix build` runtime validation was not completed in this session due long fetch/build cycle for large Joplin offline dependencies. After applying the configuration, verify with:

```bash
joplin --version
joplin sync
```

## Follow-up refactor
At user request, moved the override into a dedicated package module:

- Added `pkgs/joplin-cli/default.nix`.
- Updated overlay entry in `default.nix` to `prev.callPackage ./pkgs/joplin-cli { }`.

Behavior is unchanged; this only aligns layout with other package definitions.
