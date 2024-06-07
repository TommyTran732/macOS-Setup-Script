#!/bin/zsh
# shellcheck disable=SC1071

echo 'alias butane="docker run -i --rm --pull always quay.io/coreos/butane:release --pretty --strict <"' >> ~/.zshrc