{
  nixpkgs,
  boda-flake,
  kubectl-check-flake,
  wezterm-flake,
}: final: prev: let
  wezterm-upstream = wezterm-flake.packages.${final.stdenv.hostPlatform.system}.default;
  wezterm =
    if final.stdenv.isDarwin
    then
      wezterm-upstream.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          app="$out/Applications/WezTerm.app"
          # Sign the executables before sealing the resources in the app bundle.
          for executable in "$app"/Contents/MacOS/*; do
            /usr/bin/codesign --force --sign - "$executable"
          done
          /usr/bin/codesign --force --sign - "$app"
        '';
      })
    else wezterm-upstream;
  pinnedPkgs = import nixpkgs {
    system = final.stdenv.hostPlatform.system;
  };
in {
  kubectl-check = kubectl-check-flake.packages.${final.stdenv.hostPlatform.system}.default;
  boda = boda-flake.packages.${final.stdenv.hostPlatform.system}.default;
  nanum-myeongjo = pinnedPkgs.callPackage ./pkgs/nanum-myeongjo.nix {};
  monoplex-kr-nerd = pinnedPkgs.callPackage ./pkgs/monoplex-kr-nerd.nix {};
  dnsi = pinnedPkgs.callPackage ./pkgs/dnsi.nix {};
  empiriqa = pinnedPkgs.callPackage ./pkgs/empiriqa.nix {};
  kotlin-lsp = pinnedPkgs.callPackage ./pkgs/kotlin-lsp {};
  kubectl-sniff = pinnedPkgs.callPackage ./pkgs/kubectl-sniff.nix {};
  kubectl-rexec = pinnedPkgs.callPackage ./pkgs/kubectl-rexec.nix {};
  pchar = pinnedPkgs.callPackage ./pkgs/pchar.nix {};
  wezterm-upstream = wezterm;
  joplin-terminal = pinnedPkgs.callPackage ./pkgs/joplin-terminal {};
  kmp-lsp = pinnedPkgs.callPackage ./pkgs/kmp-lsp.nix {};
  saml-tracer = pinnedPkgs.callPackage ./pkgs/saml-tracer.nix {};
  ax-cli = pinnedPkgs.callPackage ./pkgs/ax-cli.nix {
    appleSdk = pinnedPkgs."apple-sdk";
  };
  poke-token-bar = pinnedPkgs.callPackage ./pkgs/poke-token-bar.nix {};
  minute = pinnedPkgs.callPackage ./pkgs/minute.nix {};

  kdeconnect-mac = pinnedPkgs.callPackage ./pkgs/kdeconnect-mac.nix {};
  keeping-you-awake = pinnedPkgs.callPackage ./pkgs/keeping-you-awake.nix {};
  envoy-tahoe = pinnedPkgs.callPackage ./pkgs/envoy-tahoe.nix {};
  google-messages = pinnedPkgs.callPackage ./pkgs/google-messages.nix {};
}
