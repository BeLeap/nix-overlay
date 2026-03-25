# Personal nix overlay

## Usage

To consume this overlay from another flake:

```nix
{
  inputs.beleap-overlay.url = "github:BeLeap/nix-overlay";

  outputs = { nixpkgs, beleap-overlay, ... }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [beleap-overlay.overlay];
    };
  in {
    packages.x86_64-linux.default = pkgs.boda;
  };
}
```

The flake also exposes `overlays.default`, so `beleap-overlay.overlays.default` works too.

## Binary Cache

To use the `beleap-nix-overlay` Cachix binary cache from another flake, add this to `nixConfig`:

```nix
{
  nixConfig = {
    extra-substituters = [
      "https://beleap-nix-overlay.cachix.org"
    ];
    extra-trusted-public-keys = [
      "beleap-nix-overlay.cachix.org-1:ohTqgCzvf6utSvpz73lPpOIPkRo9L5DZT3ON0F4f7Kc="
    ];
  };
}
```
