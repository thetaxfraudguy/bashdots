#!/bin/sh
cd "$(dirname "$0")" || exit 1

DOTFILES_ROOT="$(pwd -P)"
CLEAR="\033[0m"
BLUE="\033[0;34m"
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"

# Find install.sh files for each module and execute them
install_modules() {
  echo "${BLUE}Installing modules...${CLEAR}"
  find "${DOTFILES_ROOT}" -type f -name "install.sh" |
    while read -r installer; do
      echo "${BLUE}--> $(basename "$(dirname "${installer}")")${CLEAR}"
      sh -c "${installer}"
    done
}

# Link files to home directory
link_files() {
  echo "${BLUE}Linking files to home directory${CLEAR}..."
  find -H "${DOTFILES_ROOT}" -maxdepth 3 -name "*.symlink" |
    while read -r src; do
      dst="$HOME/.$(basename "${src%.*}")"
      if [ -e "${dst}" ]; then
        if [ "$(readlink "${dst}")" = "${src}" ]; then
          echo "${GREEN}${src} already linked. Skipping!${CLEAR}"
          continue
        else
          mv "${dst}" "${dst}.backup"
          echo "${YELLOW}${dst} already exists, it has been moved to ${dst}.backup${CLEAR}"
        fi
      fi
      ln -sf "${src}" "${dst}"
      echo "${GREEN}Linked ${src} to ${dst}${CLEAR}"
    done
}

link_files

if install_modules; then
  echo "${GREEN}Modules installed${CLEAR}"
else
  echo "${RED}Error installing modules, check output!${CLEAR}"
fi
