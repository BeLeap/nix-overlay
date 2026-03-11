# Add PR Package Build Workflow

- Extracted package matrix generation into the reusable workflow [`.github/workflows/define-package-matrix.yml`](/Users/beleap/pj/github.com/beleap/nix-overlay/.github/workflows/define-package-matrix.yml) so multiple CI workflows can stay aligned with flake package outputs.
- Updated [`.github/workflows/cachix.yml`](/Users/beleap/pj/github.com/beleap/nix-overlay/.github/workflows/cachix.yml) to call the reusable matrix workflow instead of duplicating the `nix eval` logic inline.
- Added [`.github/workflows/pull-request-build.yml`](/Users/beleap/pj/github.com/beleap/nix-overlay/.github/workflows/pull-request-build.yml) to build every exposed package on `pull_request`, without requiring Cachix credentials.
