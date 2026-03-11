{
  description = "BeLeap personal nix-overlay";

  nixConfig = {
    extra-substituters = [
      "https://beleap-nix-overlay.cachix.org"
    ];
    extra-trusted-public-keys = [
      "beleap-nix-overlay.cachix.org-1:ohTqgCzvf6utSvpz73lPpOIPkRo9L5DZT3ON0F4f7Kc="
    ];
  };

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
        packages =
          {
            inherit (pkgs)
              dnsi
              empiriqa
              envoy-tahoe
              joplin-terminal
              kotlin-lsp
              kubectl-sniff
              nanum-myeongjo
              pchar
              wezterm-null
              ;
          }
          // pkgs.lib.optionalAttrs (system == "aarch64-darwin") {
            inherit (pkgs) kdeconnect-mac;
          };
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
