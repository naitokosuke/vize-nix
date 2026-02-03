{
  cachix.pull = [ "vize-nix" ];
  cachix.push = "vize-nix";

  scripts.build.exec = "nix build .#vize --print-build-logs";
  scripts.test.exec = "nix run .#vize -- --version";
}
