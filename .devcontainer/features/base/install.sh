#!/usr/bin/bash -e
apt-get update -y
apt-get upgrade -y
apt-get install -y software-properties-common
apt-get install -y ca-certificates gpg wget dnsutils curl iputils-ping netcat-openbsd neovim

touch /etc/gitconfig
cat <<EOF > /etc/gitconfig
[url "git@<YOUR_GITLAB_DOMAIN>:"]
	insteadOf = https://<YOUR_GITLAB_DOMAIN>/
EOF
chmod 644 /etc/gitconfig

cat <<EOF > /etc/.netrc
machine <YOUR_GITLAB_DOMAIN>
    login <YOUR_GITLAB_USERNAME>
    password <YOUR_GITLAB_PERSONAL_ACCESS_TOKEN>
EOF
chmod 644 /etc/.netrc
