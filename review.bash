#!/usr/bin/env bash

set -euxo pipefail

pr_number="$1"
output_dir="$(mktemp --tmpdir --directory "nixpkgs-reviewing-workspace.${pr_number}.XXXXXX")"

gh workflow run 'nixpkgs-review.yml' --field pr-number="$pr_number"
sleep 10 # TODO: Ensure to get correct ID
run_id="$(gh run list --workflow=nixpkgs-review.yml --branch main --limit 1 --json databaseId --jq '.[].databaseId')"

# Replace with like a `gh workflow run --watch` if https://github.com/cli/cli/issues/3559 is resolved
gh run watch "$run_id" --interval 10 # Don't use --exit-status to make sure the downloading
gh run download "$run_id" --dir "$output_dir"

echo "Downloaded the files in $output_dir"

tree "$output_dir"

fd --absolute-path . "$output_dir"

# TODO: Trim excess headers
fd --absolute-path report.md "$output_dir" | ruby ./sort.rb | xargs cat
