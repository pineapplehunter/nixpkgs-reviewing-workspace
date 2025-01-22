#!/usr/bin/env bash

set -euxo pipefail

gh run list --workflow 'nixpkgs-review.yml' \
	--json name,databaseId,status,updatedAt \
	--template '{{range .}}{{tablerow .name .databaseId .status (timeago .updatedAt)}}{{end}}' |
	fzf --nth 1 --bind 'enter:become(./resume.bash {2})'
