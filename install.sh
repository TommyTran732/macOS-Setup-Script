#!/bin/zsh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/autoupdate
brew install gnupg pinentry-mac exiftools
brew install --cask brave-browser docker gimp github google-drive ivpn lens lyx onlyoffice spotify visual-studio-code wireshark yubico-manager
