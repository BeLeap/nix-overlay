{joplin-cli}:
joplin-cli.overrideAttrs (final: prev: {
  postInstall =
    (prev.postInstall or "")
    + ''
      appCliApp="$out/lib/packages/app-cli/app"
      packageJson="$appCliApp/package.json"
      if [ ! -f "$packageJson" ]; then
        mkdir -p "$appCliApp"
        printf '%s\n' '{"version":"${final.version}"}' >"$packageJson"
      fi
    '';
})
