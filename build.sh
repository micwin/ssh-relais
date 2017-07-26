#!/usr/bin/env bash
#
# script to build the docker image.
#
# you might probably run that using sudo
#
#     sudo ./build.sh
#
# or without
#
#     ./build.sh
#
# depending on how your docker has been installed

docker build -t outpost/ssh-relais:ubuntu .
