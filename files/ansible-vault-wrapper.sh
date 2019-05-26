#!/bin/bash

# gpg2 --batch --armor --symmetric --passphrase "test" xxx.txt.orig
/usr/bin/gpg2 --batch --decrypt --passphrase "${ANSIBLE_VAULT_PASSWORD}" /etc/ansible/inventory/"${ANSIBLE_VAULT_PW_FILE:-vault_phrase.asc}"

exit 0
