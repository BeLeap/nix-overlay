{
  description = "Fonts for nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      rec {
        packages.nanum-myeongjo = pkgs.stdenvNoCC.mkDerivation {
          name = "nanum-myeongjo";
          dontConfigue = true;
          dontUnpack = true;
          src = pkgs.fetchurl {
            url = "https://hangeul.pstatic.net/hangeul_static/webfont/NanumMyeongjo/NanumMyeongjo.ttf";
            hash = "sha256-60qd4wIu0nRMBipMRTMuh3FUYr9y817cNP6EUptKwT0=";
          };
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp $src $out/share/fonts/truetype/
          '';
        };

        overlay = prev: final: {
          nanum-myeongjo = packages.nanum-myeongjo;
        };
      }
    );
}
