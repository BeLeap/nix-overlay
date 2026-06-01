let
  flake = builtins.getFlake (toString ./..);

  skippedPackages = {
    # joplin-cli previously trapped with SIGILL under the GitHub x86_64 Linux
    # QEMU setup. Keep it out of aarch64-linux CI until native arm64 builds are
    # validated separately.
    aarch64-linux = ["joplin-terminal"];
  };

  isSupported = system: name:
    !(builtins.elem name (skippedPackages.${system} or []));

  mkEntries = system: os:
    builtins.map
    (name: {
      inherit name os system;
    })
    (builtins.filter
      (isSupported system)
      (builtins.attrNames flake.packages.${system}));
in {
  include =
    mkEntries "x86_64-linux" "ubuntu-latest"
    ++ mkEntries "aarch64-linux" "ubuntu-24.04-arm"
    ++ mkEntries "aarch64-darwin" "macos-latest";
}
