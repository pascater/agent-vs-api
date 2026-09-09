#!/usr/bin/env bash
# Read GitHub repository facts from the REST API.
#
#   ./verify.sh owner/repo [...]    check the repositories you name
#   ./verify.sh -f list.txt         one owner/repo per line
#   cat list.txt | ./verify.sh -    the same, from standard input
#   ./verify.sh --dataset           re-run the measurement in data/repos.csv
#
# Optional: export GITHUB_TOKEN=...   raises the rate limit above 60 req/hour.

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
AUTH=()
[ -n "${GITHUB_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")

fetch() { curl -sf "${AUTH[@]}" "https://api.github.com/repos/$1"; }
num()   { grep -m1 "\"$1\"" | tr -dc '0-9'; }

check() {
  printf '%-40s %8s %7s %10s %12s\n' REPOSITORY STARS FORKS ARCHIVED "LAST PUSH"
  printf '%s\n' "------------------------------------------------------------------------------"
  while read -r repo; do
    [ -z "$repo" ] && continue
    json=$(fetch "$repo")
    if [ -z "$json" ]; then
      printf '%-40s %8s\n' "$repo" "not found"
      continue
    fi
    printf '%-40s %8s %7s %10s %12s\n' "$repo" \
      "$(printf '%s' "$json" | num stargazers_count)" \
      "$(printf '%s' "$json" | num forks_count)" \
      "$(printf '%s' "$json" | grep -m1 '"archived"' | grep -o 'true\|false')" \
      "$(printf '%s' "$json" | grep -m1 '"pushed_at"' | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')"
  done
}

dataset() {
  printf '%-38s %8s %10s %8s\n' REPOSITORY AGENT "API 9 SEP" LIVE
  printf '%s\n' "--------------------------------------------------------------------"
  tail -n +2 "$HERE/data/repos.csv" | while IFS=, read -r repo agent recorded rest; do
    live=$(fetch "$repo" | num stargazers_count)
    [ -z "$live" ] && live="?"
    printf '%-38s %8s %10s %8s\n' "$repo" "$agent" "$recorded" "$live"
  done
}

case "${1:-}" in
  --dataset)  dataset ;;
  -f)         check < "${2:?usage: verify.sh -f list.txt}" ;;
  -)          check ;;
  ""|-h|--help) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//' ;;
  *)          printf '%s\n' "$@" | check ;;
esac
