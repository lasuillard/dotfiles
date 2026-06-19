# shellcheck shell=sh

: '
Move to the directory of the given file.
'

cd "$(dirname "$1")" || exit
