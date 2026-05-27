{
  stdenvNoCC,
  firefox,
  imagemagick,
}:
stdenvNoCC.mkDerivation {
  pname = "google-messages";
  version = "1.0";

  dontUnpack = true;

  nativeBuildInputs = [
    imagemagick
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/Messages.app/Contents/MacOS"
    mkdir -p "$out/Applications/Messages.app/Contents/Resources/Messages.iconset"

    makeIcon() {
      size="$1"
      outFile="$2"

      magick -size "$size"x"$size" xc:none \
        -fill '#1a73e8' \
        -draw "roundrectangle $((size * 8 / 100)),$((size * 8 / 100)) $((size * 92 / 100)),$((size * 92 / 100)) $((size * 18 / 100)),$((size * 18 / 100))" \
        -fill white \
        -draw "roundrectangle $((size * 23 / 100)),$((size * 30 / 100)) $((size * 77 / 100)),$((size * 63 / 100)) $((size * 8 / 100)),$((size * 8 / 100))" \
        -draw "polygon $((size * 36 / 100)),$((size * 62 / 100)) $((size * 29 / 100)),$((size * 75 / 100)) $((size * 51 / 100)),$((size * 62 / 100))" \
        -fill '#1a73e8' \
        -draw "circle $((size * 39 / 100)),$((size * 47 / 100)) $((size * 39 / 100)),$((size * 50 / 100))" \
        -draw "circle $((size * 50 / 100)),$((size * 47 / 100)) $((size * 50 / 100)),$((size * 50 / 100))" \
        -draw "circle $((size * 61 / 100)),$((size * 47 / 100)) $((size * 61 / 100)),$((size * 50 / 100))" \
        "$outFile"
    }

    makeIcon 16 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_16x16.png"
    makeIcon 32 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_16x16@2x.png"
    makeIcon 32 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_32x32.png"
    makeIcon 64 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_32x32@2x.png"
    makeIcon 128 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_128x128.png"
    makeIcon 256 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_128x128@2x.png"
    makeIcon 256 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_256x256.png"
    makeIcon 512 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_256x256@2x.png"
    makeIcon 512 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_512x512.png"
    makeIcon 1024 "$out/Applications/Messages.app/Contents/Resources/Messages.iconset/icon_512x512@2x.png"
    /usr/bin/iconutil \
      -c icns "$out/Applications/Messages.app/Contents/Resources/Messages.iconset" \
      -o "$out/Applications/Messages.app/Contents/Resources/Messages.icns"
    rm -r "$out/Applications/Messages.app/Contents/Resources/Messages.iconset"

    cat > "$out/Applications/Messages.app/Contents/Info.plist" <<EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
      "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>CFBundleName</key>
      <string>Messages</string>
      <key>CFBundleExecutable</key>
      <string>google-messages</string>
      <key>CFBundleIdentifier</key>
      <string>dev.beleap.google-messages</string>
      <key>CFBundleVersion</key>
      <string>1.0</string>
      <key>CFBundleIconFile</key>
      <string>Messages</string>
      <key>CFBundlePackageType</key>
      <string>APPL</string>
    </dict>
    </plist>
    EOF

    cat > "$out/Applications/Messages.app/Contents/MacOS/google-messages" <<EOF
    #!/bin/sh
    set -eu

    profile_dir="\''${HOME}/Library/Application Support/Firefox/Google Messages"
    mkdir -p "\''${profile_dir}"

    exec "${firefox}/Applications/Firefox.app/Contents/MacOS/firefox" \\
      --no-remote \\
      --profile "\''${profile_dir}" \\
      --new-window "https://messages.google.com/web/conversations"
    EOF

    chmod +x "$out/Applications/Messages.app/Contents/MacOS/google-messages"

    runHook postInstall
  '';

  meta.platforms = [
    "aarch64-darwin"
  ];
}
