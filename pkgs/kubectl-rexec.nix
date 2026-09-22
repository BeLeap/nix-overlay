{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "kubectl-rexec";
  version = "0.3.4";

  src = fetchFromGitHub {
    owner = "Adyen";
    repo = "kubectl-rexec";
    rev = "v${version}";
    hash = "sha256-BbwNNU/XmIYDa/hl3dr/PvIqUU+QpTEXrfwSJL5cKBQ=";
  };

  vendorHash = "sha256-EGrkSp0Vpcbjd+VWndXjFpk/cqSbE1MQBnDQPjnvPpQ=";

  meta = {
    description = "Tooling to make audited kubectl exec easy";
    homepage = "https://github.com/Adyen/kubectl-rexec";
    license = lib.licenses.mit;
    mainProgram = "kubectl-rexec";
    platforms = lib.platforms.unix;
  };
}
