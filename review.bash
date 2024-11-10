#!/usr/bin/env bash

set -euxo pipefail

pr_number="$1"
output_dir="$(mktemp --directory)"

gh workflow run 'nixpkgs-review.yml' --field pr-number="$pr_number"
sleep 3
run_id="$(gh run list --workflow=nixpkgs-review.yml --branch main --limit 1 --json databaseId --jq '.[].databaseId')"

gh run watch "$run_id" --exit-status && gh run download "$run_id" --dir "$output_dir"

echo "Downloaded the files in $output_dir"

tree "$output_dir"
