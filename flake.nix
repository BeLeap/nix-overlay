{
  description = "Fonts for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      overlay = import ./.;
    in
    {
      overlays = {
        default = overlay;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          stdenv = pkgs.stdenvNoCC;
          packages = with pkgs; [
            fontconfig

            nanum-myeongjo
          ];
        };
      }
    );
}
