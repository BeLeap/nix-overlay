{
  fetchurl,
  lib,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "saml-tracer";
  version = "1.9.2";
  addonId = "{d3e01ff2-9a3a-4007-8f6e-7acd9a5de263}";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4507778/saml_tracer-${version}.xpi";
    hash = "sha256-fNFdAGpqy8nZpDuZy5XtgCKbRbYFWtx6ltEi4x8M1dk=";
  };

  preferLocalBuild = true;
  allowSubstitutes = true;
  passthru = {
    inherit addonId;
  };

  buildCommand = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p "$dst"
    install -v -m644 "$src" "$dst/${addonId}.xpi"
  '';

  meta = {
    homepage = "https://github.com/SimpleSAMLphp/SAML-tracer/";
    description = "A tool for viewing SAML and WS-Federation messages sent through the browser during single sign-on and single logout.";
    license = lib.licenses.bsd2;
    mozPermissions = [
      "webRequest"
      "<all_urls>"
    ];
    platforms = lib.platforms.all;
  };
}
