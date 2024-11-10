# nixpkgs-reviewing-workspace

[![Dev Shell Status](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/devshell.yml/badge.svg?branch=main)](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/devshell.yml?query=branch%3Amain+)

## Motivation

Checking the build result of nixpkgs in multiple platforms is an annoying task.

- I basically do not use macOS these days and only have an old and slow Intel MacBook.
- Having few devices or smartphones if I am walking.
- Several packages are very heavy to build, they take a long time and require many resources.

Solution

- GitHub Actions are free for pricing in public repositories. 😋

## Matrix

As I understand that, Which github provided runner matches the Nix supported [systems](https://github.com/NixOS/nixpkgs/blob/nixos-24.05/lib/systems/flake-systems.nix).

Excluding no extra runner as _large_. Which cannot be used in free plan.

| Nix            | GitHub       |
| -------------- | ------------ |
| x86_64-linux   | ubuntu-24.04 |
| x86_64-darwin  | macos-13     |
| aarch64-darwin | macos-15     |

## Usage

[Run workflow](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/nixpkgs-review.yml)

Build results will be uploaded in the artifact.\
You can download it with `gh run download [<run-id>]`

```console
> output_dir="$(mktemp --directory)"; gh run download 11763704048 --dir "$output_dir"; cd "$output_dir"; tree
direnv: unloading
.
├── nixpkgs-review-files-pr-354285-ARM64-macOS
│   └── pr-354285
│       ├── attrs.nix
│       ├── report.json
│       └── report.md
├── nixpkgs-review-files-pr-354285-X64-Linux
│   └── pr-354285
│       ├── attrs.nix
│       ├── report.json
│       └── report.md
└── nixpkgs-review-files-pr-354285-X64-macOS
    └── pr-354285
        ├── attrs.nix
        ├── report.json
        └── report.md

7 directories, 9 files
```
