# nixpkgs-reviewing-workspace

[![Dev Shell Status](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/devshell.yml/badge.svg?branch=main)](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/devshell.yml?query=branch%3Amain+)
[![nixpkgs-review Status](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/devshell.yml/nixpkgs-review.yml)](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/nixpkgs-review.yml)

## Motiation

Checking the build result of nixpkgs in multiple platforms is an annoying task.

- I basically do not use macOS these days and only have an old and slow Intel MacBook.
- Having few devices or smartphones if I am walking.
- Several packages are very heavy to build, they take a long time and require many resources.

Solution

- GitHub Actions are free for pricing in public repositories. 😋

## Usage

[Run workflow](https://github.com/kachick/nixpkgs-reviewing-workspace/actions/workflows/nixpkgs-review.yml)

Build results will be uploaded in the artifact.\
You can download it with `gh run download [<run-id>]`

For example, if I need to test <https://github.com/NixOS/nixpkgs/pull/329482>, run with these params.

```yaml
subcmd: pr
args: https://github.com/NixOS/nixpkgs/pull/329482
```
