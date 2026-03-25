# Update Cachix GitHub Action for Node.js 24 migration

- Updated `.github/workflows/cachix.yml` to use `cachix/cachix-action@v17` instead of `@v15`.
- This addresses the GitHub Actions deprecation warning for Node.js 20-based JavaScript actions in CI builds.
- Confirmed upstream latest release tag with `curl -fsSL https://api.github.com/repos/cachix/cachix-action/releases/latest | jq -r '.tag_name'`.
