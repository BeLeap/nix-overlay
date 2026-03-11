final: prev: {
  nanum-myeongjo = prev.callPackage ./pkgs/nanum-myeongjo.nix {};
  dnsi = prev.callPackage ./pkgs/dnsi.nix {};
  empiriqa = prev.callPackage ./pkgs/empiriqa.nix {};
  kotlin-lsp = prev.callPackage ./pkgs/kotlin-lsp {};
  kubectl-sniff = prev.callPackage ./pkgs/kubectl-sniff.nix {};
  pchar = prev.callPackage ./pkgs/pchar.nix {};
  wezterm-null = prev.callPackage ./pkgs/wezterm {};
  joplin-terminal = prev.callPackage ./pkgs/joplin-terminal {};

  kdeconnect-mac = prev.callPackage ./pkgs/kdeconnect-mac.nix {};
  envoy-tahoe = prev.callPackage ./pkgs/envoy-tahoe.nix {};
}
