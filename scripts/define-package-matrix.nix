let
  flake = builtins.getFlake (toString ./..);

  qemuUnsupportedPackages = {
    # joplin-cli runs a target-architecture Yarn/Node install step that
    # currently traps with SIGILL under the GitHub x86_64 Linux QEMU setup.
    aarch64-linux = ["joplin-terminal"];
  };

  isSupported = system: name:
    !(builtins.elem name (qemuUnsupportedPackages.${system} or []));

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
    ++ mkEntries "aarch64-linux" "ubuntu-latest"
    ++ mkEntries "aarch64-darwin" "macos-latest";
}
