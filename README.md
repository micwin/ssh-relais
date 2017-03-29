# the ssh-relais

A bash shell reachable via ssh. docker image to lightning fastly setup a ssh server for use as a jump point.

# starting container

## using a public key

Start a docker that binds its ssh port to localhost 4023 and gives acces to root for user with a private key corresponding to given public key.

> docker run -d -p4023:22 -e ROOT_SSH_PUBKEY="$(ssh-show-public)" outpost/ssh-relais

## using a password

Start a docker that binds its ssh port to localhost 4023 and allows access user root with a clear text password.

> ROOT_PASS="someotherpassword"
> docker run -d -p 4022:22 -e ROOT_PASS outpost/ssh-relais

# accessing the container

Use ssh

> ssh root@localhost -p4022

Depending on wether you use password access or (correctly configured) public key access, you will be prompted for a password or not.


# environment vars

- ROOT_PASS : the password to connect as root. leave unset to disable root password access.

- ROOT_SSH_PUBKEY : the public key to use when connecting to the container as root.

# some more ideas

- try mounting your home as /root ( _-v $HOME:/root_ ) to get your known bash environment to work with. Make sure not to _-e ROOT_SSH_PUBKEY_ because if done so, your _authorized_keys_ gets polluted with given public key

- use the ssh relay to access a dmz or a docker-only network

- use the ssh relay as a jump point proxy
