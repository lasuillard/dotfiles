# shellcheck disable=SC2148

is_devcontainer() {
  if [ "$REMOTE_CONTAINERS" = "true" ] || [ "$CODESPACES" = "true" ]; then
    echo "true"
    return
  fi
  echo "false"
  return
}
