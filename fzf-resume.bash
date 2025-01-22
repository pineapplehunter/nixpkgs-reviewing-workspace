#!/usr/bin/env bash

set -euxo pipefail

gh run list --workflow 'nixpkgs-review.yml' \
	--json status,databaseId,updatedAt \
	--template '{{range .}}{{tablerow .status .databaseId (timeago .updatedAt)}}{{end}}' |
	fzf --nth 2 --bind 'enter:become(./resume.bash {2})'
