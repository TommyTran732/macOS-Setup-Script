#!/bin/zsh

defaults write com.apple.mail EnableBundles -bool true
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/autoupdate
brew install free-gpgmail
brew install --cask docker github google-drive ivpn lens spotify visual-studio-code
