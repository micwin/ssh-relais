# the ssh-relais

docker image to lightning fastly setup a ssh server for use as a multi user ssh jump point, or temporary privacy storage.

# starting container

users are created at container startup (not at image creation), utilizing a mounted file _ssh-users.lst_. This file is a pipe separated list of users and corresponding public keys, looking like that:

```
mirsanmir|ssh-rsa AAAAB3NzaC1yc2EA+Q84Qs8y7Z3eROnTQzkb5Tmp24o0P2Yx4BH9FElmEHu0rM4+HSKwlDPrgAxbA2rMKnFo/qeJJgGXqiDf8IQm6jUrM9DK4x6C+YtWArARHvBCeHIU8CPlmv7sheKWnbDcyoa8gLsioeSpVer+N8Uw4GAatpsrufyVBTJP7T+uwvGKNoyYx mirsanmir@localhost
doabollana|ssh-rsa AAAAB3NzaC1yc2EA+Q84Qs8y7Z3eROnTQzkb5Tmp24o0P2Yx4BH+YtWArARHvBCeHIU8CPlmv7sheKWnbDcyoa8gLsioeSpVer+N8Uw4GAatpsrufyVB9FElmEHu0rM4+HSKwlDPrgAxbA2rMKnFo/qeJJgGXqiDf8IQm6jUrM9DK4x6CTJP7T+uwvGKNoyYx doabollana@outpost
leodone|ssh-rsa AAAAB3NzaC1yc2EA+Q84Qs8y7Z3eROnTQzkb5Tmp24o0P2Yx4BH+YtWArARHvBCeHIU8CPlmv7sheKWnbDcyoa8gLsioeSpVer+N8Uw4GAatpsrufyVB9FElmEHu0rM4+HSKwlDPrgAxbA2rMKnFo/qeJJgGXqiDf8IQm6jUrM9DK4x6CTJP7T+uwvGKNoyYx leodone@outpost
```

mount file when starting container:

> docker run -d -p 4022:22 --volume my_ssh-users.lst:/ssh-users.lst --name ssh-relais outpost/ssh-relais:latest

# accessing the container

Use ssh

> ssh -A leodone@localhost -p4022

# trespassing the container

Since agent forwarding is activated by default, you could directly trespass the container with following command:

>  ssh -A -t leodone@localhost -p4022 -C "ssh -A someotheruser@10.249.18.30"

Note that you have no dns name resolution inside the container.

# putting a users home into ramdisk

To put home directory of example user _leodone_ into a ramdisk, run container with following command:

> docker run -d -p 4022:22 --tmpfs /home/leodone --volume my_ssh-users.lst:/ssh-users.lst --name ssh-relais outpost/ssh-relais:latest

Later, you can access this very volatile home directory with sftp

> sftp -oPort=4022 leodone@local

or scp

> scp -P 4022 ./some_local_file.txt leodone@localhost:/home/leodone/some_local_file.txt

*Notes:*

- this is an excellent way to get some very private temporary storage over the net. If container is closed, contents of home directory /home/leodone is effectively wiped without a trace.

- since such a container is bound to the memory of its host, such a container cannot be restarted or moved to another host without losing data. One can use this to detect tampering with container.

# accessing root

There is no way of accessing root via ssh. Use docker command instead:

> docker exec -it outpost/ssh-relais /bin/bash
