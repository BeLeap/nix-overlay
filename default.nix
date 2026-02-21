final: prev: {
  nanum-myeongjo = prev.callPackage ./pkgs/nanum-myeongjo.nix { };
  dnsi = prev.callPackage ./pkgs/dnsi.nix { };
  kdeconnect-mac = prev.callPackage ./pkgs/kdeconnect-mac.nix { };
  empiriqa = prev.callPackage ./pkgs/empiriqa.nix { };
  kotlin-lsp = prev.callPackage ./pkgs/kotlin-lsp { };
  envoy-tahoe = prev.callPackage ./pkgs/envoy-tahoe.nix { };
  kubectl-sniff = prev.callPackage ./pkgs/kubectl-sniff.nix { };
  pchar = prev.callPackage ./pkgs/pchar.nix { };
  wezterm-null = prev.callPackage ./pkgs/wezterm { };
}
