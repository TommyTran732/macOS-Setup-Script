#!/bin/zsh
# shellcheck disable=SC1071

echo "gpgconf --launch gpg-agent" >> ~/.zshrc
echo "export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh" >> ~/.zshrc
echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf
echo "08106E4A223469E096995A44B8EC0E5BB58C643C" >> ~/.gnupg/sshcontrol