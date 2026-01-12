# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.2] - 2026-01-12

### Changed

- Replace flake-utils with pure Nix implementation
- Limit supported systems to aarch64-darwin only

### Removed

- Remove flake-utils dependency

## [0.0.1] - 2026-01-12

### Added

- Initial Nix flake for vize v0.0.1-alpha.19
- `packages.default` and `apps.default` outputs
- Multi-platform support via flake-utils

[Unreleased]: https://github.com/naitokosuke/vize-nix/compare/v0.0.2...HEAD
[0.0.2]: https://github.com/naitokosuke/vize-nix/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/naitokosuke/vize-nix/releases/tag/v0.0.1
