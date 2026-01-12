{
  description = "Unofficial personal Nix flake for vize - High-Performance Vue.js Toolchain in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        vize = pkgs.rustPlatform.buildRustPackage rec {
          pname = "vize";
          version = "0.0.1-alpha.19";

          src = pkgs.fetchFromGitHub {
            owner = "ubugeeei";
            repo = "vize";
            rev = "v${version}";
            hash = "sha256-t6gCHTrbY9ULYS0g9pxqa1UdcLqdufzr7ksbvZTuues=";
          };

          cargoLock = {
            lockFile = "${src}/Cargo.lock";
          };

          cargoBuildFlags = [
            "-p"
            "vize"
          ];

          meta = {
            description = "High-performance Vue.js toolchain in Rust";
            homepage = "https://github.com/ubugeeei/vize";
            license = pkgs.lib.licenses.mit;
            maintainers = [ ];
            mainProgram = "vize";
          };
        };
      in
      {
        packages = {
          inherit vize;
          default = vize;
        };

        apps = {
          vize = flake-utils.lib.mkApp {
            drv = vize;
          };
          default = self.apps.${system}.vize;
        };
      }
    );
}
