{ pkgs, ... }:
{
  cachix.pull = [ "vize-nix" ];
  cachix.push = "vize-nix";

  packages = [
    pkgs.yj
  ];

  scripts.build.exec = "nix build .#vize --print-build-logs";
  scripts.test.exec = "nix run .#vize -- --version";
  scripts.generate-workflows.exec = ''
    set -e
    mkdir -p .github/workflows
    for f in $(nix build .#workflows --print-out-paths --no-link)/*.yml; do
      cp "$f" .github/workflows/
      echo "Generated: .github/workflows/$(basename "$f")"
    done
  '';
}
