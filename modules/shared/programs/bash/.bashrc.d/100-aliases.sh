# shellcheck shell=bash

# https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

# Change directory to the parent directory of the given path
alias cdd='source cdd.sh'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Go back
function - {
  cd "$OLDPWD" || return
}

# Temporary context
alias mktmp='mktemp'
alias cdtmp='cd "$(mktemp --directory)"'

# List environment variables in sorted order (uppercase first, underscore then lowercase at last)
function _env() {
  if [ $# -eq 0 ]; then
    command env -0 "$@" | LC_ALL=C sort --zero-terminated | tr '\0' '\n'
  else
    command env "$@"
  fi
}
alias env='_env'

# Show environment variables but only uppercase keys
function _ENV() {
  if [ $# -eq 0 ]; then
    _env "$@" | grep --extended-regexp --color=never '^([A-Z_]+)='
  else
    command env "$@"
  fi
}
alias ENV="_ENV"

# Utilities
alias cls='clear'
alias ls='ls --color=auto'
alias ll='ls -l --all --classify'

alias own='sudo chown --preserve-root --recursive "$(id -u):$(id -g)"'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias mkdir='mkdir --verbose --parents'
if command -v colordiff &>/dev/null; then
  alias diff='colordiff'
fi

# Continue downloading
alias wget='wget --continue'

# Network
alias ports='netstat --all --listening --numeric --tcp --udp --programs'

# External utilities to set alias for
declare -A aliases
aliases=(
  [aa]='aws-annoying'
  [ans]='ansible'
  [cld]='claude'
  [cod]='codex'
  [cop]='copilot'
  [d]='docker'
  [dc]='docker compose'
  [dr]='direnv'
  [dv]='devobs'
  [g]='git'
  [gc]='gcloud'
  [gmi]='gemini'
  [h]='helm'
  [hist]='history'
  [ic]='istioctl'
  [j]='just'
  [K]='k9s'
  [k]='kubectl'
  [kc]='kilocode'
  [kilo]='kilocode'
  [kk]='kubectl kustomize'
  [m]='make'
  [mk]='minikube'
  [pl]='pulumi'
  [pls]='pulumi stack'
  [px]='pulumi-extra'
  [soc]='sea-orm-cli'
  [tal]='talosctl'
  [tf]='tofu'
  [tg]='terragrunt'
  [tp]='telepresence'
  [vg]='vagrant'
)

# shellcheck disable=SC1090
source ~/.bash_completion.d/complete_alias

for key in "${!aliases[@]}"; do
  # Skip if the alias is hiding an existing command
  if command -v "$key" &>/dev/null; then
    continue
  fi

  # shellcheck disable=SC2139
  alias "$key"="${aliases[$key]}"

  # https://unix.stackexchange.com/a/332522
  # Enable autocomplete for the alias as well
  complete -F _complete_alias "$key"
done

# Safety nets
# ----------------------------------------------------------------------------
# Do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm --interactive --preserve-root'

# Ask confirmation
alias mv='mv --interactive'
alias cp='cp --interactive'
alias ln='ln --interactive'

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
