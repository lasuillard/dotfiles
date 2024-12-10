#!/usr/bin/env bash

# https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Utilities
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias mkdir='mkdir -pv'
if command -v colordiff &> /dev/null; then
    alias diff='colordiff'
fi

# Continue downloading
alias wget='wget -c'

# Network
alias ports='netstat -tulanp'

# Custom scripts
alias cdd='source cdd.sh'

# External utilities but do not set alias if hiding existing command
declare -A aliases

aliases=(
    [ans]='ansible'
    [d]='docker'
    [g]='git'
    [gc]='gcloud'
    [h]='helm'
    [ic]='istioctl'
    [K]='k9s'
    [k]='kubectl'
    [kk]='kubectl kustomize'
    [mk]='minikube'
    [pl]='pulumi'
    [pls]='pulumi stack'
    [tal]='talosctl'
    [tf]='tofu'
    [tg]='terragrunt'
    [tp]='telepresence'
    [vg]='vagrant'
)

for key in "${!aliases[@]}"; do
    # Skip if the alias is overwriting an existing command
    if command -v "$key" &> /dev/null; then
        continue
    fi

    # shellcheck disable=SC2139
    alias "$key"="${aliases[$key]}"
done

# Safety nets
# ----------------------------------------------------------------------------
# Do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# Ask confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
