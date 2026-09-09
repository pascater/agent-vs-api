#!/usr/bin/env bash
# Ask GitHub for the number instead of asking an agent to read the page.
#
#   ./verify.sh                     check the bundled dataset in data/repos.csv
#   ./verify.sh owner/repo [...]    check any repositories you name
#   ./verify.sh -f list.txt         check one owner/repo per line from a file
#   cat list.txt | ./verify.sh -    same, from standard input
#
# Optional: export GITHUB_TOKEN=...   raises the rate limit above 60 req/hour.

set -uo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
AUTH=()
[ -n "${GITHUB_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")

field() { grep -m1 "\"$1\"" | tr -dc '0-9'; }

fetch() { curl -sf "${AUTH[@]}" "https://api.github.com/repos/$1"; }

check_free() {
  printf '%-40s %8s %7s %10s %12s\n' REPOSITORY STARS FORKS ARCHIVED "LAST PUSH"
  printf '%s\n' "------------------------------------------------------------------------------"
  while read -r repo; do
    [ -z "$repo" ] && continue
    json=$(fetch "$repo")
    if [ -z "$json" ]; then
      printf '%-40s %8s\n' "$repo" "not found"
      continue
    fi
    stars=$(printf '%s' "$json" | field stargazers_count)
    forks=$(printf '%s' "$json" | field forks_count)
    arch=$(printf '%s' "$json" | grep -m1 '"archived"' | grep -o 'true\|false')
    push=$(printf '%s' "$json" | grep -m1 '"pushed_at"' | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')
    printf '%-40s %8s %7s %10s %12s\n' "$repo" "$stars" "$forks" "$arch" "$push"
  done
}

check_dataset() {
  printf '%-38s %8s %8s %8s %8s\n' REPOSITORY PUBLISHED AGENT RECORDED LIVE
  printf '%s\n' "-------------------------------------------------------------------------"
  tail -n +2 "$HERE/data/repos.csv" | while IFS=, read -r repo published agent recorded rest; do
    live=$(fetch "$repo" | field stargazers_count)
    [ -z "$live" ] && live="?"
    printf '%-38s %8s %8s %8s %8s\n' "$repo" "$published" "$agent" "$recorded" "$live"
  done
  echo
  echo "PUBLISHED  the figure the original list published"
  echo "AGENT      what an AI agent reported after reading the rendered page"
  echo "RECORDED   what the API returned on 9 September 2026"
  echo "LIVE       what the API returns right now"
}

case "${1:-}" in
  "")   check_dataset ;;
  -f)   check_free < "${2:?usage: verify.sh -f list.txt}" ;;
  -)    check_free ;;
  -h|--help) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//' ;;
  *)    printf '%s\n' "$@" | check_free ;;
esac
