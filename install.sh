#!/bin/zsh

defaults write com.apple.mail EnableBundles -bool true
echo "export HOMEBREW_NO_ANALYTICS=1" >> ~/.zshrc
echo "gpgconf --launch gpg-agent" >> ~/.zshrc
echo "export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh" >> ~/.zshrc

#Comment this line out if on Intel Mac
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zshrc

#Comment this line out if you don't have Touch ID
awk 'NR==2 {print "auth       sufficient     pam_tid.so"} 1' /etc/pam.d/sudo > /etc/pam.d/sudo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/autoupdate
brew install --cask android-platform-tools docker github gpg-suite microsoft-auto-update microsoft-edge mullvadvpn parallels raspberry-pi-imager veracrypt visual-studio-code