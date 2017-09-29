#! /usr/bin/env bash

set -e

# recreate host keys with every restart
ssh-keygen -A


while read line ; do
	username=$(echo $line | cut  -d'|' -f1)
	ssh_public_key=$(echo $line | cut  -d'|' -f2)
	[[ -e "/home/$username/.ssh/authorized_keys" ]] && continue
	useradd -m -s /bin/bash $username
	mkdir /home/$username/.ssh
	echo $ssh_public_key > /home/$username/.ssh/authorized_keys
	echo " Host *
	  ForwardAgent yes" >> /home/$username/.ssh/config
	chown -R $username:$username /home/$username
	chmod -R u=rwX,g=,o= /home/$username

done < /ssh-users.lst

# start sshd
/usr/sbin/sshd -D
