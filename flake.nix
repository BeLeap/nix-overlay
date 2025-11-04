{
  description = "Fonts for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      ...
    }:
    {
      overlays = {
        default = ./overlay.nix;
      };
    };
}
