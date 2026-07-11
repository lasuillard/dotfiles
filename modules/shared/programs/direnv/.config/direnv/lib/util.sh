# shellcheck shell=sh

is_devcontainer() {
  if [ "$REMOTE_CONTAINERS" = "true" ] || [ "$CODESPACES" = "true" ]; then
    echo "true"
    return
  fi
  echo "false"
  return
}

slugify() {
  echo "$1" |
    tr '[:upper:]' '[:lower:]' |
    sed --regexp-extended 's/[^[:alnum:]]+/-/g' |
    sed --regexp-extended 's/^-+|-+$//g'
}

snake_case() {
  echo "$1" |
    sed --regexp-extended 's/[^[:alnum:]]+/_/g' |
    sed --regexp-extended 's/^_+|_+$//g'
}

gh_pr_number() {
  pr_number="$(gh pr view --json number --jq '.number' 2>/dev/null || echo 'X')"
  echo "$pr_number"
}
