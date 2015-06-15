#! /usr/bin/env bash

# Copyright (c) 2015 The Akaros Authors
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version. See LICENSE for details.
#
# Kevin Klues <klueska@gmail.com>

# Create a user from the info passed in for your username and group
: ${USER:=${USER}}
: ${GROUP:=${GROUP}}
: ${UID:=${UID}}
: ${GID:=${GID}}
if [ ! -d "/home/${USER}" ]; then
	ADDHOME="-m"
fi
groupadd -g ${GID} ${GROUP}
useradd -u ${UID} -r -p '' \
        ${ADDHOME} \
        -G ${GROUP},kvm,tty \
        -d "/home/${USER}" \
        -s /bin/bash "${USER}"

# Add this user to the sudoers file
echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

