# vize-nix

Unofficial Nix flake for [Vize](https://github.com/ubugeeei/vize) (personal use).

This flake repackages the official prebuilt binaries from [GitHub Releases](https://github.com/ubugeeei-prod/vize/releases), so installation takes seconds with no Rust toolchain or source build.

## What is Vize?

Vize is a high-performance Vue.js toolchain written in Rust. It provides compilation, linting, formatting, and type checking for Vue Single File Components.

## Supported systems

- `aarch64-darwin` (Apple Silicon macOS)

Other platforms can be added by extending [`sources.json`](./sources.json).

## Usage

Run without installing:

```sh
nix run github:naitokosuke/vize-nix -- --help
```

Install into your profile:

```sh
nix profile install github:naitokosuke/vize-nix
```

Use as a flake input:

```nix
{
  inputs.vize-nix.url = "github:naitokosuke/vize-nix";

  # then e.g. inputs.vize-nix.packages.${system}.default
}
```

`overlays.default` is also available and adds `pkgs.vize`.

## Versioning

Tags follow `<vize-version>-nix.<revision>`

- the vize part tracks the upstream release
- the `-nix.N` revision increments for packaging-only changes

A scheduled workflow checks upstream every 12 hours and opens an update PR automatically.

## References

- [Vize repository](https://github.com/ubugeeei/vize)
- [Vize binary releases](https://github.com/ubugeeei-prod/vize/releases)
