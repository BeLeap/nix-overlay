{ joplin-cli }:
joplin-cli.overrideAttrs (finalAttrs: prevAttrs: {
  postInstall =
    (prevAttrs.postInstall or "")
    + ''
      appCliApp="$out/lib/packages/app-cli/app"
      packageJson="$appCliApp/package.json"
      if [ ! -f "$packageJson" ]; then
        mkdir -p "$appCliApp"
        printf '%s\n' '{"version":"${finalAttrs.version}"}' >"$packageJson"
      fi
    '';
})
