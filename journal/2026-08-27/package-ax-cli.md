# Package ax-cli

- Added `ax-cli` 0.3.0 from the upstream `v0.3.0` tag.
- Exposed the package through the overlay and the Apple Silicon Darwin flake
  package set because the CLI uses macOS accessibility APIs.
- The installed executable is named `ax`.
- Corrected the Cargo vendor hash to the value produced by Nix's
  `fetchCargoVendor` implementation after the initial macOS CI build reported
  the fixed-output hash mismatch.
- Added Swift to the native build tools and selected Apple SDK 15 after the
  subsequent macOS build showed that `screencapturekit` could not find a Swift
  compiler and rejected the default Apple SDK 14 for its macOS 15 APIs.
- Added SwiftPM after CI confirmed the compiler wrapper was present but the
  `swift build` command could not locate `swift-build`. Disabled SwiftPM's
  build and check hooks so Cargo remains responsible for this Rust package.
- Added explicit pre-build checks for both `swift` and `swift-build`. A future
  Swift packaging regression will now fail immediately with a focused error
  instead of surfacing later as a `screencapturekit` build-script panic.
- Explicitly prepended SwiftPM's binary directory to `PATH` before the Cargo
  build. The Nix Swift wrapper implements `swift build` by executing
  `swift-build` from `PATH`, so this avoids depending on setup-hook ordering.
