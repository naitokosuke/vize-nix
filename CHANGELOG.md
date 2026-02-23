# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## Versioning Scheme

This project uses the format: `<vize-version>-nix.<revision>`

- When vize upstream updates: Update the vize version part
- When vize-nix changes: Increment the `-nix.X` revision

## [Unreleased]

## [0.8.0-nix.1] - 2026-02-23

### Changed

- Update vize to v0.8.0

### Fixed

- Add `outputHashes` for git dependencies (oxc-project) to fix Nix build (#69)
- Add automatic git dependency hash detection to update-vize workflow (#69)

## [0.2.0-nix.1] - 2026-02-22

### Changed

- Update vize to v0.2.0

## [0.1.0-alpha-nix.1] - 2026-02-22

### Changed

- Update vize to v0.1.0-alpha

## [0.0.1-alpha.120-nix.1] - 2026-02-21

### Changed

- Update vize to v0.0.1-alpha.120

## [0.0.1-alpha.114-nix.1] - 2026-02-20

### Changed

- Update vize to v0.0.1-alpha.114

## [0.0.1-alpha.102-nix.1] - 2026-02-17

### Changed

- Update vize to v0.0.1-alpha.102

## [0.0.1-alpha.101-nix.1] - 2026-02-10

### Changed

- Update vize to v0.0.1-alpha.101

### Added

- Automated CHANGELOG.md update in vize version update workflow (#59)

## [0.0.1-alpha.100-nix.1] - 2026-02-10

### Changed

- Update vize to v0.0.1-alpha.100

## [0.0.1-alpha.86-nix.1] - 2026-02-10

### Changed

- Update vize to v0.0.1-alpha.86

### Fixed

- Use PAT for automated PR creation to trigger CI (#55)

## [0.0.1-alpha.83-nix.1] - 2026-02-09

### Changed

- Update vize to v0.0.1-alpha.83
- Leverage devenv in CI to unify with local environment (#34)
- Replace Magic Nix Cache with Cachix in CI workflows (#42)
- Adopt new versioning scheme aligned with vize (#12)
- Reduce vize update check frequency to 12 hours (#15)

### Added

- Build verification step before creating PR (#24)
- Automatic tag creation on release (#14)
- Skip CI for documentation-only changes (#45)
- Cachix cache in update-vize workflow

### Fixed

- Skip upstream tests that require TTY in Nix sandbox (#51)
- Use GNU sed via Nix for macOS compatibility in update-vize workflow (#49)
- Use macos-latest for update-vize workflow (#47)
- Limit sed replacement to first occurrence only (#26)
- Remove unnecessary nix flake update step (#25)
- Sort tags by semantic version instead of creation date (#23)
- Add error handling to update-vize workflow (#22)

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

[Unreleased]: https://github.com/naitokosuke/vize-nix/compare/0.8.0-nix.1...HEAD
[0.8.0-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.2.0-nix.1...0.8.0-nix.1
[0.2.0-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.1.0-alpha-nix.1...0.2.0-nix.1
[0.1.0-alpha-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.120-nix.1...0.1.0-alpha-nix.1
[0.0.1-alpha.120-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.114-nix.1...0.0.1-alpha.120-nix.1
[0.0.1-alpha.114-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.102-nix.1...0.0.1-alpha.114-nix.1
[0.0.1-alpha.102-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.101-nix.1...0.0.1-alpha.102-nix.1
[0.0.1-alpha.101-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.100-nix.1...0.0.1-alpha.101-nix.1
[0.0.1-alpha.100-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.86-nix.1...0.0.1-alpha.100-nix.1
[0.0.1-alpha.86-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.83-nix.1...0.0.1-alpha.86-nix.1
[0.0.1-alpha.83-nix.1]: https://github.com/naitokosuke/vize-nix/compare/0.0.1-alpha.31-nix.1...0.0.1-alpha.83-nix.1
[0.0.1-alpha.31-nix.1]: https://github.com/naitokosuke/vize-nix/releases/tag/0.0.1-alpha.31-nix.1
