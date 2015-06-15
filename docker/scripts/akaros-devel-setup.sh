#! /usr/bin/env bash

# Copyright (c) 2015 The Akaros Authors
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version. See LICENSE for details.
#
# Kevin Klues <klueska@gmail.com>

source /bin/akaros-devel-user-setup.sh

# Set up openssh
mkdir /var/run/sshd
sed -i \
	"s/#PasswordAuthentication yes/PasswordAuthentication no/" \
	/etc/ssh/sshd_config

# Change the ownership of /dev/kvm
chown root:kvm /dev/kvm

# Set up our tty device
chown root:tty /dev/console
chmod g+rw /dev/console

# Start a screen session for the qemu-monitor
su - ${USER} -c "/usr/bin/screen -dmS qemu-monitor sleep 999999999999999999"

# If running in interactive mode
if [ "${INTERACTIVE}" != "" ]; then
	# Start the ssh daemon so we can login from other terminals
	service ssh start > /dev/null 2>&1
	# Login as the user
	su ${USER} -l
else 
	# Start the ssh daemon as a detached process (so it blocks)
	/usr/sbin/sshd -D
fi

