# the ssh-relais

A bash shell reachable via ssh. docker image to lightning fastly setup a ssh server for use as a jump point.

# starting container

users are created at container startup (not at image creation), utilizing a mounted file _ssh-users.lst_. This file is a pipe separated list of users and corresponding public keys, looking like that:

```
mirsanmir|ssh-rsa AAAAB3NzaC1yc2EA+Q84Qs8y7Z3eROnTQzkb5Tmp24o0P2Yx4BH9FElmEHu0rM4+HSKwlDPrgAxbA2rMKnFo/qeJJgGXqiDf8IQm6jUrM9DK4x6C+YtWArARHvBCeHIU8CPlmv7sheKWnbDcyoa8gLsioeSpVer+N8Uw4GAatpsrufyVBTJP7T+uwvGKNoyYx mirsanmir@localhost
doabollana|ssh-rsa AAAAB3NzaC1yc2EA+Q84Qs8y7Z3eROnTQzkb5Tmp24o0P2Yx4BH+YtWArARHvBCeHIU8CPlmv7sheKWnbDcyoa8gLsioeSpVer+N8Uw4GAatpsrufyVB9FElmEHu0rM4+HSKwlDPrgAxbA2rMKnFo/qeJJgGXqiDf8IQm6jUrM9DK4x6CTJP7T+uwvGKNoyYx doabollana@outpost
leodone|ssh-rsa AAAAB3NzaC1yc2EA+Q84Qs8y7Z3eROnTQzkb5Tmp24o0P2Yx4BH+YtWArARHvBCeHIU8CPlmv7sheKWnbDcyoa8gLsioeSpVer+N8Uw4GAatpsrufyVB9FElmEHu0rM4+HSKwlDPrgAxbA2rMKnFo/qeJJgGXqiDf8IQm6jUrM9DK4x6CTJP7T+uwvGKNoyYx leodone@outpost
```

mount file when starting container:

> docker run -d -p 4022:22 --volume my_ssh-users.lst:/ssh-users.lst --name ssh-relais outpost/ssh-relais:ubuntu

# accessing the container

Use ssh

> ssh -A leodone@localhost -p4022

Agent Forwarding is activated by default

# accessing root

There is no way of accessing root via ssh. Use docker command instead:

> docker exec -it ssh-relais /bin/bash
