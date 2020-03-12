docker rm -f ssh-relais-$USER || true

ID=$(docker run -d -v $PWD/ssh-users.lst:/ssh-users.lst --hostname=ssh-relais-$USER --name=ssh-relais-$USER outpost/ssh-relais:disco)
echo IP is $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $ID)
