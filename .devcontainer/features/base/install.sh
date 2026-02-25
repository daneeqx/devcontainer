#!/usr/bin/bash -e
apt-get update -y
apt-get upgrade -y
apt-get install -y software-properties-common
apt-get install -y ca-certificates gpg wget dnsutils curl iputils-ping netcat-openbsd neovim

cat <<EOF | tee /etc/.netrc > /dev/null
machine <YOUR GITLAB URL>
    login <YOUR GITLAB USERNAME>
    password <YOUR GITLAB PERSONAL ACCESS TOKEN>
EOF
chmod 644 /etc/.netrc

cat <<EOF | tee -a /etc/gitconfig > /dev/null
[url "git@<YOUR GITLAB URL>:"]
	insteadOf = https://<YOUR GITLAB URL>/
[url "git@<YOUR GITLAB URL>:"]
	insteadOf = https://<YOUR GITLAB URL>/
[user]
    name = <YOUR NAME>
    email = <YOUR EMAIL>
EOF
chmod 644 /etc/gitconfig
