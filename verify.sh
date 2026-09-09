#!/usr/bin/env bash
# Check the star counts in data/repos.csv against the live GitHub REST API.
#
# The point of this script: an agent that reads a rendered GitHub page can
# return a confident, well formatted, completely wrong number. The API returns
# an integer. Ask the API.
#
# Usage:   ./verify.sh
# Optional: export GITHUB_TOKEN=...   raises the rate limit above 60 req/hour.

set -uo pipefail
CSV="$(dirname "$0")/data/repos.csv"
AUTH=()
[ -n "${GITHUB_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")

printf '%-38s %8s %8s %8s %8s\n' REPOSITORY LISTED AGENT RECORDED LIVE
printf '%s\n' "-------------------------------------------------------------------------"

tail -n +2 "$CSV" | while IFS=, read -r repo listed agent recorded rest; do
  live=$(curl -sf "${AUTH[@]}" "https://api.github.com/repos/$repo" \
    | grep -m1 '"stargazers_count"' | tr -dc '0-9')
  [ -z "$live" ] && live="?"
  printf '%-38s %8s %8s %8s %8s\n' "$repo" "$listed" "$agent" "$recorded" "$live"
done

echo
echo "LISTED   what the original LinkedIn list published"
echo "AGENT    what an AI agent reported after reading the rendered page"
echo "RECORDED what the API returned on 9 September 2026"
echo "LIVE     what the API returns right now"
