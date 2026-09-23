{
  lib,
  stdenv,
  nodejs,
  fetchFromGitHub,
  yarn-berry_4,
  python3,
  pkg-config,
  libsecret,
  rsync,
  xcbuild,
  buildPackages,
  clang_20,
  runCommand,
}: let
  # Yarn 4.14 tries to resolve cached packages from the registry with this
  # lockfile. Keep the builder on the 4.13 series until the offline hook is
  # fixed upstream.
  yarn-berry-offline-4-13 = yarn-berry_4.yarn-berry-offline.overrideAttrs (_: {
    version = "4.13.0";
    src = fetchFromGitHub {
      owner = "yarnpkg";
      repo = "berry";
      rev = "refs/tags/@yarnpkg/cli/4.13.0";
      hash = "sha256-FP15a2ueihDm6f/GdXsnqI5drVHo0EtbmrhCZfRdugQ=";
    };
  });

  # yarnBerryConfigHook embeds the Yarn executable path, so overriding the
  # offline package alone still makes the hook invoke Yarn 4.14.
  yarn-berry-config-hook-4-13 = runCommand "yarn-berry-config-hook-4.13" {} ''
    mkdir -p "$out/nix-support"
    sed \
      's|${yarn-berry_4.yarn-berry-offline}/bin/yarn|${yarn-berry-offline-4-13}/bin/yarn|g' \
      ${yarn-berry_4.yarnBerryConfigHook}/nix-support/setup-hook \
      > "$out/nix-support/setup-hook"
    chmod +x "$out/nix-support/setup-hook"
  '';
in

stdenv.mkDerivation (finalAttrs: {
  pname = "joplin-terminal";
  version = "3.7.1";

  src = fetchFromGitHub {
    owner = "laurent22";
    repo = "joplin";
    tag = "v${finalAttrs.version}";
    postFetch = ''
      # there's a file with a weird name that causes a hash mismatch on darwin
      rm $out/packages/app-cli/tests/support/photo*
    '';
    hash = "sha256-4o8mao7wAqDzwQgJ4QY+DPs9rtsnga6LLnq744l7HVM=";
  };

  missingHashes = ./missing-hashes.json;

  offlineCache = yarn-berry_4.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes postPatch;
    hash = "sha256-eMN2UAonUh8LBKmM5D+bL22ev25Kw2LvGMTFDDtLsok=";
  };

  nativeBuildInputs = [
    nodejs
    yarn-berry-offline-4-13
    yarn-berry-config-hook-4-13
    (python3.withPackages (ps: with ps; [ distutils ]))
    pkg-config
    libsecret
    rsync
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    xcbuild
    buildPackages.cctools
    clang_20 # clang_21 breaks keytar, sqlite
  ];

  buildInputs = [
    nodejs
  ];

  env = {
    # Disable scripts so that yarn doesn't immediately run them
    # We want to patch them first
    YARN_ENABLE_SCRIPTS = 0;
  };

  postPatch = ''
    # Don't immediately build everything
    sed -i '/postinstall/d' package.json
    # Don't install onenote-converter subpackage deps
    sed -i '/onenote-converter/d' packages/{lib,app-cli}/package.json
  '';

  buildPhase = ''
    runHook preBuild

    unset YARN_ENABLE_SCRIPTS

    yarn config set enableInlineBuilds true

    for node_modules in packages/*/node_modules; do
      patchShebangs $node_modules
    done

    yarn workspaces focus root joplin
    yarn workspaces foreach -Rptvi --from joplin run tsc
    yarn workspaces foreach -Rtvi --from joplin run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    # Remove dev dependencies
    yarn workspaces focus --production root joplin

    mkdir -p $out/lib/packages
    mkdir $out/bin
    mv packages/{app-cli,renderer,tools,utils,lib,htmlpack,turndown{,-plugin-gfm},fork-*} $out/lib/packages/
    rm -rf $out/lib/packages/lib/node_modules/canvas

    # Remove extra files
    rm -rf $out/lib/packages/app-cli/{app/*.test.ts,*.md,.*ignore,tests/,tools/,*.js,*.json,*.sh}

    # Link final binary
    chmod +x $out/lib/packages/app-cli/app/main.js
    ln -s $out/lib/packages/app-cli/app/main.js $out/bin/joplin
    patchShebangs $out/bin/joplin

    runHook postInstall
  '';

  postInstall = ''
    appCli="$out/lib/packages/app-cli"
    appCliApp="$appCli/app"
    if [ ! -f "$appCliApp/package.json" ]; then
      mkdir -p "$appCliApp"
      printf '%s\n' '{"version":"${finalAttrs.version}"}' >"$appCliApp/package.json"
    fi
    if [ ! -f "$appCli/package.json" ]; then
      printf '%s\n' '{"version":"${finalAttrs.version}"}' >"$appCli/package.json"
    fi
  '';

  meta = {
    changelog = "https://github.com/laurent22/joplin/releases/v${finalAttrs.version}";
    description = "CLI client for Joplin";
    homepage = "https://joplinapp.org/";
    license = lib.licenses.agpl3Plus;
    mainProgram = "joplin";
    maintainers = with lib.maintainers; [ pyrox0 ];
  };
})
