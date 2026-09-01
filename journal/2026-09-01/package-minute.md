# Package Minute

- Added Minute 1.12.1 from its signed upstream macOS release archives.
- Packaged only the upstream `arm64` archive because this overlay does not need
  x86_64 Darwin support for Minute.
- Exposed Minute as a flake package and check on `aarch64-darwin`.
- Removed AppleDouble metadata while installing the application bundle because it is not part of the signed app.
