{
  boda-flake,
  kubectl-check-flake,
}: final: prev: {
  kubectl-check = kubectl-check-flake.packages.${final.stdenv.hostPlatform.system}.default;
  boda = boda-flake.packages.${final.stdenv.hostPlatform.system}.default;
  nanum-myeongjo = prev.callPackage ./pkgs/nanum-myeongjo.nix {};
  dnsi = prev.callPackage ./pkgs/dnsi.nix {};
  empiriqa = prev.callPackage ./pkgs/empiriqa.nix {};
  kotlin-lsp = prev.callPackage ./pkgs/kotlin-lsp {};
  kubectl-sniff = prev.callPackage ./pkgs/kubectl-sniff.nix {};
  pchar = prev.callPackage ./pkgs/pchar.nix {};
  wezterm-null = prev.callPackage ./pkgs/wezterm {};
  joplin-terminal = prev.callPackage ./pkgs/joplin-terminal {};
  rusty-kotlin-lsp = prev.callPackage ./pkgs/rusty-kotlin-lsp.nix {};

  kdeconnect-mac = prev.callPackage ./pkgs/kdeconnect-mac.nix {};
  envoy-tahoe = prev.callPackage ./pkgs/envoy-tahoe.nix {};
  google-messages = prev.callPackage ./pkgs/google-messages.nix {};
}
