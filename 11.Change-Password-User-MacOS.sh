#!/bin/bash

unset HISTFILE

USERNAME="USER"
OLDPASS="Abc123"
NEWPASS="123Abc"

/usr/bin/dscl . -passwd /Users/"${USERNAME}" "${OLDPASS}" "${NEWPASS}"
security set-keychain-password -o "${OLDPASS}" -p "${NEWPASS}" /Users/"${USERNAME}"/Library/Keychains/login.keychain

history -c