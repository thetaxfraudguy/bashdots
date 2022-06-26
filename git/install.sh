#!/bin/sh
# If email is already set, who are we to muck with your setup?
if [ -z  "$(git config --global --get user.email)" ]; then
  user ' - What is your github author name?'
  read -r user_name
  user ' - What is your github author email?'
  read -r user_email

  git config --global user.name "$user_name"
  git config --global user.email "$user_email"

  git config --global include.path ~/.gitconfig.local
fi

if [ "$(uname -s)" = "Darwin" ]; then
  git config --global credential.helper osxkeychain
else
  git config --global credential.helper cache
fi
