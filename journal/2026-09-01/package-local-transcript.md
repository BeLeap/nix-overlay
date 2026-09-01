# Package Local Transcript

- Added the Local Transcript 1.1.0 Apple Silicon release as a macOS application package.
- Used the upstream release artifact and its published SHA-256 digest.
- Exposed the package through the overlay, flake packages, and Darwin checks.
- The application downloads the Whisper large-v3 model at runtime; the model is not included in the Nix package.
- Made DMG extraction explicit with `undmg "$src"` rather than relying on the generic unpack phase to select the tool.
