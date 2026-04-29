{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "kubectl-sniff";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "eldadru";
    repo = "ksniff";
    rev = "v${version}";
    hash = "sha256-Dz+qnpUKdhNdYC74lqUZXwCk73jb6pY2tIGjtTvNiUQ=";
  };

  vendorHash = "sha256-7pSpOF8UASWqRMWaomoUBA3pD8t0qWiaIcGlXEm0Yx0=";

  doCheck = false;
}
