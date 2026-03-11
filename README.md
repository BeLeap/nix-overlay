# Personal nix overlay

## Binary Cache

```nix
{
  description = "Some Fancy Flake";

  nixConfig = {
    extra-substituters = [
      "https://beleap-nix-overlay.cachix.org"
    ];
    extra-trusted-public-keys = [
      "beleap-nix-overlay.cachix.org-1:ohTqgCzvf6utSvpz73lPpOIPkRo9L5DZT3ON0F4f7Kc="
    ];
  };

  inputs = {
    # ...
  };
}
```
