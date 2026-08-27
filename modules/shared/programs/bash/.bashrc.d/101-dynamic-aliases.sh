# shellcheck shell=bash

# Dynamic command runner selection for pip packages
_get_pip_runner() {
  if command -v uv &>/dev/null; then
    # Use uv if available
    local runner="uv tool run --from"
  else
    # Fallback to pipx if uv is not available
    local runner="pipx run --spec"
  fi
  echo "$runner"
}

# Dynamic aliases using command not found handler
command_not_found_handle() {
  # Dogfooding my own tools, if the command is in the form of <alias>@<revision>,
  # then run the corresponding pipx command with the specified revision
  if [[ "$1" == *@* ]]; then
    local cmd="${1%%@*}"
    local rev="${1##*@}"

    # Handle the case where the revision is omitted, e.g., "aa@" should default to "main"
    if [[ "$rev" == "$cmd" || -z "$rev" ]]; then
      rev="main"
    fi

    local runner
    runner="$(_get_pip_runner)"
    case "$cmd" in
    aa)
      $runner "git+https://github.com/lasuillard-s/aws-annoying@${rev}" aws-annoying "${@:2}"
      return $?
      ;;
    dvo)
      $runner "git+https://github.com/lasuillard-s/devobs@${rev}" devobs "${@:2}"
      return $?
      ;;
    esac

    # Don't handle other commands if not specified in the case statement
  fi

  # Original error handler
  echo "bash: $1: command not found" >&2
  return 127
}
