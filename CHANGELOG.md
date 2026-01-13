# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## Versioning Scheme

This project uses the format: `<vize-version>-nix.<revision>`

- When vize upstream updates: Update the vize version part
- When vize-nix changes: Increment the `-nix.X` revision

## [Unreleased]

## [0.0.1-alpha.31-nix.1] - 2026-01-13

### Changed

- Adopt new versioning scheme aligned with vize upstream
- Replace flake-utils with pure Nix implementation
- Limit supported systems to aarch64-darwin only
- Update vize to v0.0.1-alpha.31

### Removed

- Remove flake-utils dependency

### Added

- CI workflow for build checks
- Binary caching via Cachix with devenv

[Unreleased]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.31-nix.1...HEAD
[0.0.1-alpha.31-nix.1]: https://github.com/naitokosuke/vize-nix/releases/tag/0.0.1-alpha.31-nix.1
