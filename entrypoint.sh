#! /usr/bin/env bash

set -e

# configure ssh public key access 
[[ "none" != "${ROOT_SSH_PUBKEY}" ]] && \
	mkdir /root/.ssh && \
	echo "${ROOT_SSH_PUBKEY}" >> /root/.ssh/authorized_keys && \
	chown -R root:root /root/.ssh && \
	chmod -R go-rwx /root/.ssh

# configure password access (not recommended)
[[ "none" != "${ROOT_PASS}" ]] && \
	echo "Setting root pass to $ROOT_PASS ..." && \
	echo "root:$ROOT_PASS" | chpasswd && \
        /bin/sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

echo "Starting SSH daemon..." 
/usr/sbin/sshd -D -e
