{
  description = "BeLeap personal nix-overlay";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }: let
    overlay = import ./.;
  in
    {
      overlays = {
        default = overlay;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [overlay];
        };
      in {
        checks = pkgs.lib.optionalAttrs (system == "aarch64-darwin") {
          kdeconnect-mac = pkgs.kdeconnect-mac;
        };
        devShells.default = pkgs.mkShellNoCC {
          stdenv = pkgs.stdenvNoCC;
          packages = with pkgs; [
            fontconfig

            nanum-myeongjo
            dnsi
            envoy-tahoe
            kubectl-sniff
            pchar
            kotlin-lsp
            wezterm-null
            joplin-terminal
          ];
        };
      }
    );
}
