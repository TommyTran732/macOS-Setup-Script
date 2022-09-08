#!/bin/zsh

defaults write com.apple.mail EnableBundles -bool true
echo "export HOMEBREW_NO_ANALYTICS=1" >> ~/.zshrc
echo "gpgconf --launch gpg-agent" >> ~/.zshrc
echo "export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh" >> ~/.zshrc
echo 'export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"' >> ~/.zshrc
echo 'export PATH="$(brew --prefix)/opt/openssl@3/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"' >> ~/.zshrc

#Comment this line out if on Intel Mac
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zshrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap homebrew/autoupdate
brew install free-gpgmail butane gnu-sed hugo openssl
brew install --cask microsoft-edge android-studio docker element github mullvadvpn visual-studio-code

#Add app cleaner
curl --fail --output /usr/local/bin/app-cleaner.sh https://raw.githubusercontent.com/sunknudsen/privacy-guides/master/how-to-clean-uninstall-macos-apps-using-appcleaner-open-source-alternative/app-cleaner.sh
chmod +x /usr/local/bin/app-cleaner.sh