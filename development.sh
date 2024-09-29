#!/bin/zsh
# shellcheck disable=SC1071

# Comment this line out if you don't have Touch ID
awk 'NR==2 {print "auth       sufficient     pam_tid.so"} 1' /etc/pam.d/sudo | sudo tee /etc/pam.d/sudo

# Protect Home
for user in $(ls /Users | grep -v 'Shared'); do
sudo chmod 700 /Users/"$user"
done

# Verify SSH Fingerprints
echo "VerifyHostKeyDNS yes" | sudo tee /etc/ssh/ssh_config.d/10-custom.conf
sudo chmod 644 /etc/ssh/ssh_config.d/10-custom.conf

# Disable cups
sudo launchctl unload /System/Library/LaunchDaemons/org.cups.cupsd.plist
sudo launchctl remove /System/Library/LaunchDaemons/org.cups.cupsd.plist

# Firewall rules
/usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/libexec/remoted
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/libexec/sharingd
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/libexec/sshd-keygen-wrapper
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/sbin/cupsd
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/sbin/smbd

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$(USERS)/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo "export HOMEBREW_NO_ANALYTICS=1" | sudo tee -a /etc/zshrc
export HOMEBREW_NO_ANALYTICS=1
brew tap homebrew/autoupdate

# Remember to add chrony config post install
brew install --cask android-platform-tools chronycontrol github gpg-suite-no-mail ivpn microsoft-edge orbstack powershell visual-studio-code
brew install gnu-sed
echo 'PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"' | sudo tee -a /etc/zshrc

# Configure chronyd
curl https://raw.githubusercontent.com/TommyTran732/macOS-Setup-Script/main/etc/chrony.d/chrony.conf | sudo tee /etc/chrony.d/chrony.conf
sudo chmod 644 /etc/chrony.d/chrony.conf

#Install Rosetta
softwareupdate --install-rosetta

umask 022

# Setup Edge Enterprise Policies
sudo mkdir -p '/Library/Tomster Corporation/scripts/' '/Library/Tomster Corporation/prefs/' '/Library/Managed Preferences'
curl https://raw.githubusercontent.com/TommyTran732/macOS-Setup-Script/etc/Library/Tomster%20Corporation/apply_prefs.sh | sudo tee '/etc/Library/Tomster Corporation/apply_prefs.sh'
sudo chmod 744 '/Library/Tomster Corporation/scripts/apply_prefs.sh'
curl https://raw.githubusercontent.com/TommyTran732/Microsoft-Edge-Policies/main/macOS/Managed%20Preferences/com.microsoft.Edge.plist | sudo tee '/Library/Tomster Corporation/prefs/com.microsoft.Edge.plist'
curl https://raw.githubusercontent.com/TommyTran732/Microsoft-Edge-Policies/main/macOS/Preferences/com.microsoft.Edge.plist | sudo tee /Library/Preferences/com.microsoft.Edge.plist
curl https://raw.githubusercontent.com/TommyTran732/macOS-Setup-Script/main/etc/Library/LaunchDaemons/io.tommytran.prefs.plist | sudo tee /etc/Library/LaunchDaemons/io.tommytran.prefs.list
sudo launchctl load -w /Library/LaunchDaemons/io.tommytran.prefs.plist