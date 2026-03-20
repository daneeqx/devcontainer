#!/usr/bin/bash -e

GITLAB_DOMAIN="${GITLABDOMAIN}"
GITLAB_USER="${GITLABUSERNAME}"
GITLAB_TOKEN="${GITLABTOKEN}"

if [ -n "$GITLAB_TOKEN" ] && [ -n "$GITLAB_DOMAIN" ]; then
    # Git credential store for HTTPS access
    git config --system credential.helper store
    echo "https://${GITLAB_USER}:${GITLAB_TOKEN}@${GITLAB_DOMAIN}" > /etc/git-credentials
    chmod 600 /etc/git-credentials

    # .netrc in user home for Go module downloads (go mod uses ~/.netrc)
    _REMOTE_USER_HOME="${_REMOTE_USER_HOME:-/home/${_REMOTE_USER:-vscode}}"
    cat <<EOF > "${_REMOTE_USER_HOME}/.netrc"
machine ${GITLAB_DOMAIN}
login ${GITLAB_USER}
password ${GITLAB_TOKEN}
EOF
    chown "${_REMOTE_USER:-vscode}:${_REMOTE_USER:-vscode}" "${_REMOTE_USER_HOME}/.netrc"
    chmod 600 "${_REMOTE_USER_HOME}/.netrc"
fi
