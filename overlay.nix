{
  boda-flake,
  kubectl-check-flake,
  nixpkgs,
}: final: prev: let
  pinnedPkgs = import nixpkgs {
    system = final.stdenv.hostPlatform.system;
  };
in {
  kubectl-check = kubectl-check-flake.packages.${final.stdenv.hostPlatform.system}.default;
  boda = boda-flake.packages.${final.stdenv.hostPlatform.system}.default;
  nanum-myeongjo = pinnedPkgs.callPackage ./pkgs/nanum-myeongjo.nix {};
  dnsi = pinnedPkgs.callPackage ./pkgs/dnsi.nix {};
  empiriqa = pinnedPkgs.callPackage ./pkgs/empiriqa.nix {};
  kotlin-lsp = pinnedPkgs.callPackage ./pkgs/kotlin-lsp {};
  kubectl-sniff = pinnedPkgs.callPackage ./pkgs/kubectl-sniff.nix {};
  pchar = pinnedPkgs.callPackage ./pkgs/pchar.nix {};
  wezterm-null = pinnedPkgs.callPackage ./pkgs/wezterm {};
  joplin-terminal = pinnedPkgs.callPackage ./pkgs/joplin-terminal {};
  kmp-lsp = pinnedPkgs.callPackage ./pkgs/kmp-lsp.nix {};
  saml-tracer = pinnedPkgs.callPackage ./pkgs/saml-tracer.nix {};

  ax-cli = pinnedPkgs.callPackage ./pkgs/ax-cli.nix {};
  kdeconnect-mac = pinnedPkgs.callPackage ./pkgs/kdeconnect-mac.nix {};
  keeping-you-awake = pinnedPkgs.callPackage ./pkgs/keeping-you-awake.nix {};
  envoy-tahoe = pinnedPkgs.callPackage ./pkgs/envoy-tahoe.nix {};
  google-messages = pinnedPkgs.callPackage ./pkgs/google-messages.nix {};
  wezterm-dmg = pinnedPkgs.callPackage ./pkgs/wezterm-dmg.nix {};
}
