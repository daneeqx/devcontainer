#!/usr/bin/bash -e
apt-get update -y
apt-get upgrade -y
apt-get install -y software-properties-common
apt-get install -y ca-certificates gpg wget dnsutils curl iputils-ping netcat-openbsd