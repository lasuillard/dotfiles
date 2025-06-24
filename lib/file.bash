# Shell-agnostic library functions for managing shell configurations

# Replace a section in a file between two markers with new content.
#
# Usage: replace_section <file> <begin> <end> <replacement>
#
# Arguments:
#   file: The file to modify
#   begin: The begin marker for the section to remove
#   end: The end marker for the section to remove
#   replacement: The replacement text to insert
function replace_section() {
  file="$1"
  begin="$2"
  end="$3"
  replacement="$4"

  # Find the line numbers for the begin and end markers
  n_begin=$(awk "/${begin}/{print NR; exit}" "${file}")
  n_end=$(awk "/${end}/{print NR; exit}" "${file}")
  if [ -z "$n_begin" ] || [ -z "$n_end" ]; then
    echo "One or both section markers are missing in ${file}. Adding new section."
    cat <<EOT >>"$file"

$begin
$replacement
$end

EOT
    return
  fi

  n_begin=$((n_begin + 1))
  n_end=$((n_end - 1))

  # Replace the section with the new content
  echo "Replacing section from line ${n_begin} to ${n_end} in ${file} with new content."
  awk -v replacement="$replacement" "NR==${n_begin} {print replacement} NR<${n_begin} || NR>${n_end}" "$file" >"$file.tmp" &&
    mv "$file.tmp" "$file"
}
