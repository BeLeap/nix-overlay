# Fix kubectl-sniff wrapper target

- Fixed `pkgs/kubectl-sniff.nix` so the Go-built `$out/bin/cmd` executable is renamed to `$out/bin/kubectl-sniff` inside the output path.
- Added the missing shell continuation for `wrapProgram` so the tcpdump path is passed as a wrapper argument.
- Root cause: the old `install -m +x $out/bin/cmd kubectl-sniff` wrote to a relative destination instead of creating `$out/bin/kubectl-sniff`, leaving the wrapper step pointed at a non-executable path.
