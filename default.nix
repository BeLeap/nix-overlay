final: prev: {
  nanum-myeongjo = prev.callPackage ./pkgs/nanum-myeongjo.nix { };
  dnsi = prev.callPackage ./pkgs/dnsi.nix { };
  kdeconnect-mac = prev.callPackage ./pkgs/kdeconnect-mac.nix { };
}
