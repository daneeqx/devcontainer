#!/usr/bin/bash -e
cat <<EOF | tee /etc/.netrc > /dev/null
machine gitlab.nsrv.io
    login user
    password supersecretpassword
EOF
chmod 644 /etc/.netrc

cat <<EOF | tee -a /etc/gitconfig > /dev/null
[url "git@gitlab.com:"]
	insteadOf = https://gitlab.com/
EOF
chmod 644 /etc/gitconfig
