#!/bin/zsh

#Comment this line out if you don't have Touch ID
awk 'NR==2 {print "auth       sufficient     pam_tid.so"} 1' /etc/pam.d/sudo | sudo tee /etc/pam.d/sudo

# Verify SSH Fingerprints
echo "VerifyHostKeyDNS yes" | sudo tee /etc/ssh/ssh_config.d/10-custom.conf
sudo chmod 644 /etc/ssh/ssh_config.d/10-custom.conf

# Hide the administrator user
sudo dscl . create /Users/administrator IsHidden 1
sudo chflags hidden /Users/administrator
