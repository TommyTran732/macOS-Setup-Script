#!/bin/zsh

defaults write com.apple.mail EnableBundles -bool true
echo "export HOMEBREW_NO_ANALYTICS=1" >> ~/.zshrc
echo "gpgconf --launch gpg-agent" >> ~/.zshrc
echo "export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh" >> ~/.zshrc

#Comment this line out if on Intel Mac
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zshrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/autoupdate
brew install free-gpgmail android-platform-tools
brew install --cask brave-browser docker element google-drive github ivpn lens raspberry-pi-imager visual-studio-code yubico-yubikey-manager
