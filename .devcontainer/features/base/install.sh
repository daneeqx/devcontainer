#!/usr/bin/bash -e
apt-get update -y
apt-get upgrade -y
apt-get install -y software-properties-common
apt-get install -y ca-certificates gpg wget dnsutils curl iputils-ping netcat-openbsd neovim

if [ -n "${GITLABDOMAIN}" ]; then
    cat <<EOF > /etc/gitconfig
[url "git@${GITLABDOMAIN}:"]
	insteadOf = https://${GITLABDOMAIN}/
EOF
    chmod 644 /etc/gitconfig

    cat <<EOF > /etc/.netrc
machine ${GITLABDOMAIN}
    login ${GITLABUSERNAME}
    password ${GITLABTOKEN}
EOF
    chmod 600 /etc/.netrc
fi
