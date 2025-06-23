setup() {
  load '../test_helper/bats-support/load'
  load '../test_helper/bats-assert/load'
  load '../test_helper/bats-file/load'

  # shellcheck disable=SC1091
  source lib/file.bash

  cd "$(mktemp --directory)" || exit 1
  echo "Running tests in directory: $(pwd)"
}

# replace_section()
# ============================================================================
@test "replace_section: Replace section in file" {
  # Arrange
  cat <<EOF >test_file.txt
Some initial content.

@@BEGIN@@
This is the original content.
@@END@@

Some more content.
EOF

  # Act
  replace_section "test_file.txt" "@@BEGIN@@" "@@END@@" "$(
    cat <<EOF
This is
the replacement
content.
EOF
  )"

  # Assert
  cat test_file.txt
  assert_files_equal "test_file.txt" <(
    cat <<EOF
Some initial content.

@@BEGIN@@
This is
the replacement
content.
@@END@@

Some more content.
EOF
  )
}

@test "replace_section: If no section markers found, add new section to the end" {
  # Arrange
  cat <<EOF >test_file.txt
Initial content.

@@BEGIN:1@@
This section should not be replaced.
@@END:1@@

Some more content.
EOF

  # Act
  replace_section "test_file.txt" "@@BEGIN:2@@" "@@END:2@@" "$(
    cat <<EOF
New section content.
EOF
  )"

  # Assert
  cat test_file.txt
  assert_files_equal "test_file.txt" <(
    cat <<EOF
Initial content.

@@BEGIN:1@@
This section should not be replaced.
@@END:1@@

Some more content.

@@BEGIN:2@@
New section content.
@@END:2@@

EOF
  )
}
