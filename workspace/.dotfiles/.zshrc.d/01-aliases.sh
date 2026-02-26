# Git
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline -20"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gpl="git pull"
alias gst="git stash"

# Docker
alias d="docker"
alias dc="docker compose"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dl="docker logs -f"
alias dex="docker exec -it"

# Kubectl
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kl="kubectl logs -f"
alias ka="kubectl apply -f"
alias kx="kubectl exec -it"
alias kns="kubectl config set-context --current --namespace"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -lah"
alias la="ls -A"

# Utilities
alias h="history | tail -30"
alias ports="ss -tlnp 2>/dev/null || lsof -iTCP -sTCP:LISTEN"
alias myip="curl -s ifconfig.me"
alias cls="clear"

# Remove oh-my-zsh aliases that conflict with custom functions
unalias gca 2>/dev/null
