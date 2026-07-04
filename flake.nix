{
  description = "Unofficial personal Nix flake for vize - High-Performance Vue.js Toolchain in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      inherit (builtins.fromJSON (builtins.readFile ./sources.json)) version sources;

      supportedSystems = builtins.attrNames sources;
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      mkVize =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.stdenv.mkDerivation {
          pname = "vize";
          inherit version;

          src = pkgs.fetchurl {
            url = "https://github.com/ubugeeei-prod/vize/releases/download/v${version}/${sources.${system}.asset}";
            inherit (sources.${system}) hash;
          };

          sourceRoot = ".";

          installPhase = ''
            runHook preInstall
            install -Dm755 vize $out/bin/vize
            runHook postInstall
          '';

          nativeInstallCheckInputs = [ pkgs.versionCheckHook ];
          doInstallCheck = true;

          meta = {
            description = "High-performance Vue.js toolchain in Rust";
            homepage = "https://vizejs.dev";
            license = pkgs.lib.licenses.mit;
            mainProgram = "vize";
            platforms = supportedSystems;
            sourceProvenance = with pkgs.lib.sourceTypes; [ binaryNativeCode ];
          };
        };
    in
    {
      packages = forAllSystems (system: rec {
        vize = mkVize system;
        default = vize;
      });

      overlays.default = final: prev: {
        vize = self.packages.${prev.stdenv.hostPlatform.system}.vize;
      };

      checks = forAllSystems (system: {
        vize = self.packages.${system}.vize;
      });
    };
}
