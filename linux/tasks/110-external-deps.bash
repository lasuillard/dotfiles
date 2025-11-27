#!/usr/bin/env bash

# For auto-completion of aliases
# https://github.com/cykerway/complete-alias/tree/7f2555c2fe7a1f248ed2d4301e46c8eebcbbc4e2 (2022-07-30)
mkdir --parents ~/.bash_completion.d
curl --silent --fail --show-error --output ~/.bash_completion.d/complete_alias \
  https://raw.githubusercontent.com/cykerway/complete-alias/7f2555c2fe7a1f248ed2d4301e46c8eebcbbc4e2/complete_alias
