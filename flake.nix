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
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
    boda-flake = {
      url = "github:BeLeap/boda?ref=0.2616.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    kubectl-check-flake = {
      url = "github:BeLeap/kubectl-check?ref=v0.2615.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    boda-flake,
    kubectl-check-flake,
    ...
  }: let
    overlay = import ./overlay.nix {
      inherit boda-flake kubectl-check-flake nixpkgs;
    };
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
            inherit
              (pkgs)
              kubectl-check
              boda
              nanum-myeongjo
              dnsi
              empiriqa
              kotlin-lsp
              kubectl-sniff
              pchar
              wezterm-null
              joplin-terminal
              kmp-lsp
              ;
          }
          // pkgs.lib.optionalAttrs (system == "aarch64-darwin") {
            inherit
              (pkgs)
              envoy-tahoe
              kdeconnect-mac
              google-messages
              ;
          };
        checks = pkgs.lib.optionalAttrs (system == "aarch64-darwin") {
          kdeconnect-mac = pkgs.kdeconnect-mac;
        };
      }
    );
}
