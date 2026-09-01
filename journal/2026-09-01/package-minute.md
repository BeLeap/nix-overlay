# Package Minute

- Added Minute 1.12.1 from its signed upstream macOS release archives.
- Selected the upstream `arm64` or `x86_64` archive from the Nix host platform.
- Exposed Minute as a flake package and check on both supported Darwin systems.
- Removed AppleDouble metadata while installing the application bundle because it is not part of the signed app.
