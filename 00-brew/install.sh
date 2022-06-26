#!/bin/sh
if [ "$(uname -s)" = "Darwin" ]; then
  if command -v brew >/dev/null 2>&1; then
    brew update
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  echo "$(dirname "$0")/Brewfile"
  brew bundle --file "$(dirname "$0")/Brewfile"
fi
