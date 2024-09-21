#!/usr/bin/env bash

if [ -f /etc/bash_completion ]; then
    # shellcheck source=/dev/null
    source /etc/bash_completion
fi

# CLIs that support bash completion in conventional format
commands=("op" "kubectl" "helm" "minikube" "k9s" "alloy")

for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
        continue
    fi

    # shellcheck disable=SC1090
    source <("$cmd" completion bash)
done

# Terraform
if command -v terraform &>/dev/null; then
    complete -C "$(which terraform)" terraform
fi