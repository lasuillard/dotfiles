export LINUX_TEST__BASE_IMAGE="${LINUX_TEST__BASE_IMAGE:-"mcr.microsoft.com/devcontainers/base:1-ubuntu-22.04"}"

setup() {
  load '../../test_helper/bats-support/load'
  load '../../test_helper/bats-assert/load'

  echo "Running tests in $(pwd)"
}

@test "Test on Docker" {
  # Arrange
  current_hash="$(git rev-parse HEAD)"
  image_tag="linux-test:${current_hash}"
  docker build \
    --build-arg BASE_IMAGE="$LINUX_TEST__BASE_IMAGE" \
    --file ./test/integration/linux/test.Dockerfile \
    --tag "$image_tag" \
    .

  # Act
  docker run \
    --interactive \
    --rm \
    --volume "$(pwd)/test/logs:/workspace/logs" \
    "$image_tag" \
    ./linux/install.bash

  # Assert
  # ...
}
