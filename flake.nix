{
  description = "Unofficial personal Nix flake for vize - High-Performance Vue.js Toolchain in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      version = "0.263.0";

      sources = {
        "aarch64-darwin" = {
          asset = "vize-aarch64-apple-darwin.tar.gz";
          hash = "sha256-UHnvWt7wnr6N9Am51Evdapq1USjul1ZjuRipkXXisxQ=";
        };
        "aarch64-linux" = {
          asset = "vize-aarch64-unknown-linux-gnu.tar.gz";
          hash = "sha256-6NEs7gpG7jBIekzTlgKwFCeUY0jpz6doFFA+3/FPcOM=";
        };
        "x86_64-linux" = {
          asset = "vize-x86_64-unknown-linux-gnu.tar.gz";
          hash = "sha256-dxrV4GspFFFeHwG9nxBYzDuLrcvfZ8VZI1/4gDPq3YI=";
        };
      };

      supportedSystems = builtins.attrNames sources;
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      mkVize = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          src = sources.${system};
          isLinux = pkgs.stdenv.hostPlatform.isLinux;
        in
        pkgs.stdenv.mkDerivation {
          pname = "vize";
          inherit version;

          src = pkgs.fetchurl {
            url = "https://github.com/ubugeeei-prod/vize/releases/download/v${version}/${src.asset}";
            hash = src.hash;
          };

          sourceRoot = ".";

          nativeBuildInputs = pkgs.lib.optional isLinux pkgs.autoPatchelfHook;
          buildInputs = pkgs.lib.optionals isLinux [ pkgs.stdenv.cc.cc.lib ];

          installPhase = ''
            runHook preInstall
            install -Dm755 vize $out/bin/vize
            runHook postInstall
          '';

          meta = {
            description = "High-performance Vue.js toolchain in Rust";
            homepage = "https://github.com/ubugeeei/vize";
            license = pkgs.lib.licenses.mit;
            maintainers = [ ];
            mainProgram = "vize";
            platforms = supportedSystems;
            sourceProvenance = with pkgs.lib.sourceTypes; [ binaryNativeCode ];
          };
        };
    in
    {
      packages = forAllSystems (system:
        let vize = mkVize system; in
        {
          inherit vize;
          default = vize;
        }
      );

      apps = forAllSystems (system:
        let
          vize = mkVize system;
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
