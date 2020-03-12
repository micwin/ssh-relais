# an ubuntu based ssh server
#

FROM ubuntu:disco

ENV LANG C.UTF-8

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y openssh-server git sshpass vim iputils-ping curl && apt-get clean

RUN mkdir /var/run/sshd

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's@#X11UseLocalhost yes@X11UseLocalhost no@g' -i /etc/ssh/sshd_config
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

# for attached terminal
WORKDIR /

EXPOSE 22
CMD [ "/entrypoint.sh" ]
