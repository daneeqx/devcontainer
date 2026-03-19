#!/usr/bin/bash -e

GITLAB_DOMAIN="${GITLABDOMAIN}"
GITLAB_USER="${GITLABUSERNAME}"
GITLAB_TOKEN="${GITLABTOKEN}"

if [ -n "$GITLAB_TOKEN" ] && [ -n "$GITLAB_DOMAIN" ]; then
    git config --system credential.helper store
    echo "https://${GITLAB_USER}:${GITLAB_TOKEN}@${GITLAB_DOMAIN}" >> /etc/git-credentials
    chmod 600 /etc/git-credentials
fi
