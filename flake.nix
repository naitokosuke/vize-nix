{
  description = "Unofficial personal Nix flake for vize - High-Performance Vue.js Toolchain in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      mkVize = pkgs: pkgs.rustPlatform.buildRustPackage rec {
        pname = "vize";
        version = "0.43.0";

        src = pkgs.fetchFromGitHub {
          owner = "ubugeeei";
          repo = "vize";
          rev = "v${version}";
          hash = "sha256-yRRd3wZ73l2bMAfIwHWeY1MRPvf/kYUiHOiVLObbxhk=";
        };

        cargoLock = {
          lockFile = "${src}/Cargo.lock";
outputHashes = {
            "oxc_allocator-0.116.0" = "sha256-xnJ+lZwZh/F7KLebJcgPvPrAQrnlwQx9ldSJrljxnYs=";
          };
        };

        cargoBuildFlags = [
          "-p"
          "vize"
        ];

        # Skip tests during build: upstream test_backend_size requires a TTY
        # which is unavailable in Nix sandbox / CI environments
        doCheck = false;

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
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          vize = mkVize pkgs;
        in
        {
          inherit vize;
          default = vize;
        }
      );

      apps = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          vize = mkVize pkgs;
          app = {
            type = "app";
            program = "${vize}/bin/vize";
            meta = {
              description = "High-performance Vue.js toolchain in Rust";
              mainProgram = "vize";
            };
          };
        in
        {
          vize = app;
          default = app;
        }
      );
    };
}
