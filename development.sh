#!/bin/zsh

# Comment this line out if you don't have Touch ID
awk 'NR==2 {print "auth       sufficient     pam_tid.so"} 1' /etc/pam.d/sudo | sudo tee /etc/pam.d/sudo

# Protect Home
for user in $(ls /Users | grep -v 'Shared'); do
sudo chmod 700 /Users/$user
done

# Verify SSH Fingerprints
echo "VerifyHostKeyDNS yes" | sudo tee /etc/ssh/ssh_config.d/10-custom.conf
sudo chmod 644 /etc/ssh/ssh_config.d/10-custom.conf

#Enable Safari debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu 1

#I nstall Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$(USERS)/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "export HOMEBREW_NO_ANALYTICS=1" >> /etc/zshrc
export HOMEBREW_NO_ANALYTICS=1
brew tap homebrew/autoupdate
brew tap homebrew/cask-versions
brew install --cask android-platform-tools chronycontrol github gpg-suite-no-mail microsoft-edge mullvadvpn orbstack powershell visual-studio-code
brew install gnu-sed
echo 'PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"' >> /etc/zshrc
