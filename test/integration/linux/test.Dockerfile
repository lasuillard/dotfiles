ARG BASE_IMAGE='mcr.microsoft.com/devcontainers/base:1-ubuntu-22.04'

FROM "${BASE_IMAGE}"

WORKDIR /workspace
COPY . ./

CMD ["./install.sh"]
