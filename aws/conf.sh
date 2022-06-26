# shellcheck disable=SC2148
complete -C '/usr/local/bin/aws_completer' aws

creds() { export AWS_PROFILE=$1; }
