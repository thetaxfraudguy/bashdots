#!/bin/sh
if [ "$(uname -s)" = "Darwin" ]; then
  if command -v brew >/dev/null 2>&1; then
    echo "brew installed, updating"
    # brew update
  else
    echo "brew not installed. WTF?"
    # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  echo "$(dirname "$0")/Brewfile"
#   brew bundle --file
fi
