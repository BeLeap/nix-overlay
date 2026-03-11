# Personal nix overlay

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
