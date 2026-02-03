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
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      mkVize = pkgs: pkgs.rustPlatform.buildRustPackage rec {
        pname = "vize";
        version = "0.0.1-alpha.31";

        src = pkgs.fetchFromGitHub {
          owner = "ubugeeei";
          repo = "vize";
          rev = "v${version}";
          hash = "sha256-hj6OToT2b53DE/9fkytL/+FVIHry9nqxAXwxW8YIaoI=";
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
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          vize = mkVize pkgs;
          workflowsModule = import ./workflows { inherit pkgs; };
        in
        {
          inherit vize;
          default = vize;
          workflows = workflowsModule.default;
        }
      );

      apps = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          vize = mkVize pkgs;
          workflowsModule = import ./workflows { inherit pkgs; };
          app = {
            type = "app";
            program = "${vize}/bin/vize";
            meta = {
              description = "High-performance Vue.js toolchain in Rust";
              mainProgram = "vize";
            };
          };
          generateWorkflows = {
            type = "app";
            program = toString (pkgs.writeShellScript "generate-workflows" ''
              set -e
              mkdir -p .github/workflows
              for f in ${workflowsModule.default}/*.yml; do
                cp "$f" .github/workflows/
                echo "Generated: .github/workflows/$(basename "$f")"
              done
            '');
          };
        in
        {
          vize = app;
          default = app;
          generate-workflows = generateWorkflows;
        }
      );
    };
}
