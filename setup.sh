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

umask 022

# Disable cups
sudo launchctl unload /System/Library/LaunchDaemons/org.cups.cupsd.plist
sudo launchctl remove /System/Library/LaunchDaemons/org.cups.cupsd.plist

# Firewall rules
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/bin/python3
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/bin/ruby
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/libexec/remoted
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/libexec/sharingd
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/libexec/sshd-keygen-wrapper
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/sbin/cupsd
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /usr/sbin/smbd

# Setup Edge Enterprise Policies
sudo mkdir -p '/Library/Tomster Corporation/scripts/' '/Library/Tomster Corporation/prefs/' '/Library/Managed Preferences'
curl https://raw.githubusercontent.com/TommyTran732/macOS-Setup-Script/etc/Library/Tomster%20Corporation/apply_prefs.sh | sudo tee '/etc/Library/Tomster Corporation/apply_prefs.sh'
sudo chmod 744 '/Library/Tomster Corporation/scripts/apply_prefs.sh'
curl https://raw.githubusercontent.com/TommyTran732/Microsoft-Edge-Policies/main/macOS/Managed%20Preferences/com.microsoft.Edge.plist | sudo tee '/Library/Tomster Corporation/prefs/com.microsoft.Edge.plist'
curl https://raw.githubusercontent.com/TommyTran732/Microsoft-Edge-Policies/main/macOS/Preferences/com.microsoft.Edge.plist | sudo tee /Library/Preferences/com.microsoft.Edge.plist
curl https://raw.githubusercontent.com/TommyTran732/macOS-Setup-Script/main/etc/Library/LaunchDaemons/io.tommytran.prefs.plist | sudo tee /etc/Library/LaunchDaemons/io.tommytran.prefs.list
sudo launchctl load -w /Library/LaunchDaemons/io.tommytran.prefs.plist
