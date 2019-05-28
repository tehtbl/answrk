#!/bin/bash

# gpg2 --batch --armor --symmetric --passphrase "supersecurepw" /etc/ansible/vault_phrase
/usr/bin/gpg2 --batch --decrypt --passphrase "${ANS_VAULT_PW}" /etc/ansible/"${ANS_VAULT_PW_FILE:-vault_phrase.asc}"

exit 0
