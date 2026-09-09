#!/usr/bin/env bash
# Re-check the star counts recorded in data/repos.csv against the live GitHub API.
# Usage: ./verify.sh
# Optional: export GITHUB_TOKEN=... to raise the rate limit above 60 requests/hour.

set -uo pipefail
CSV="$(dirname "$0")/data/repos.csv"
AUTH=()
[ -n "${GITHUB_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")

printf '%-38s %8s %9s %7s   %s\n' REPOSITORY LISTED RECORDED LIVE NOTE
printf '%s\n' "---------------------------------------------------------------------------------"

tail -n +2 "$CSV" | while IFS=, read -r repo listed recorded rest; do
  live=$(curl -sf "${AUTH[@]}" "https://api.github.com/repos/$repo" \
    | grep -m1 '"stargazers_count"' | tr -dc '0-9')
  if [ -z "$live" ]; then
    printf '%-38s %8s %9s %7s   %s\n' "$repo" "$listed" "$recorded" "?" "fetch failed"
    continue
  fi
  note=""
  [ "$live" -lt "$listed" ] && note="listed above live count"
  printf '%-38s %8s %9s %7s   %+d %s\n' "$repo" "$listed" "$recorded" "$live" \
    "$((live - recorded))" "$note"
done
