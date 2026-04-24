{
  description = "Unofficial personal Nix flake for vize - High-Performance Vue.js Toolchain in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, rust-overlay }:
    let
      supportedSystems = [
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
      };

      mkVize = pkgs:
        let
          rustToolchain = pkgs.rust-bin.stable.latest.default;
          rustPlatform = pkgs.makeRustPlatform {
            cargo = rustToolchain;
            rustc = rustToolchain;
          };
        in
        rustPlatform.buildRustPackage rec {
          pname = "vize";
          version = "0.49.0";

          src = pkgs.fetchFromGitHub {
            owner = "ubugeeei";
            repo = "vize";
            rev = "v${version}";
            hash = "sha256-DPnHmVrFn9b7dHb3HSgFFmFKH/6D8yfHbxUeYdIcW8E=";
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
          pkgs = pkgsFor system;
          vize = mkVize pkgs;
        in
        {
          inherit vize;
          default = vize;
        }
      );

      apps = forAllSystems (system:
        let
          pkgs = pkgsFor system;
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
