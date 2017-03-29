# ssh server and  bash on alpine
#
# VERSION               0.2

FROM alpine:latest
MAINTAINER Michael Winkler ""

# base setup
ENV LC_ALL=en_US.UTF-8

# the root password
ENV ROOT_PASS none

# enable pubkey access and disable password access
ENV ROOT_SSH_PUBKEY none

# make sure the package repository is up to date
RUN apk update && apk upgrade

# install bash
RUN apk add bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

# setup ssh server
RUN apk add openssh && /usr/bin/ssh-keygen -A

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ADD motd /etc/motd

WORKDIR /root

EXPOSE 22
CMD [ "/entrypoint.sh" ]
