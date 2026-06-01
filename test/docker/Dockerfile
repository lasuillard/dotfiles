FROM mcr.microsoft.com/devcontainers/base:2.0.5-ubuntu-24.04

RUN useradd --create-home --shell /bin/bash nonroot

# IMPORTANT: The /nix directory must be created if you don't have access to use sudo in runtime
RUN mkdir --mode=0755 /nix && chown nonroot:nonroot /nix

# Nix cache directory for faster iteration of feedback loop
RUN mkdir --parents /home/nonroot/.cache/nix \
    && chown --recursive nonroot:nonroot /home/nonroot/.cache

USER nonroot:nonroot

WORKDIR /home/nonroot/dotfiles
COPY --chown=nonroot:nonroot . .
