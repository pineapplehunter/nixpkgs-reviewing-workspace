set -x

pr_number="$1"

gh workflow run 'nixpkgs-review.yml' --field pr-number="$pr_number"
sleep 10 # TODO: Ensure to get correct ID
run_id="$(gh run list --workflow=nixpkgs-review.yml --branch main --limit 1 --json databaseId --jq '.[].databaseId')"

resume "$run_id"
