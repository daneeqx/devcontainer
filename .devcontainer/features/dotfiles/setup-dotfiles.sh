#!/usr/bin/env bash
set -e

CONFIG="/workspace/.dotfiles"
HOME="/home/vscode"

# Create directories (.ssh is mounted from host)
mkdir -p "$CONFIG/.zshrc.d"

# Create default zshrc.d example if empty
[ -d "$CONFIG/.zshrc.d" ] && [ -z "$(ls -A "$CONFIG/.zshrc.d")" ] && \
    echo "# Add your custom shell config here" > "$CONFIG/.zshrc.d/00-example.sh"

# Add zshrc.d sourcing (idempotent)
grep -q "zshrc.d" "$HOME/.zshrc" 2>/dev/null || cat >> "$HOME/.zshrc" << 'EOF'

# Source user scripts
for f in /workspace/.dotfiles/.zshrc.d/*.sh(N); do source "$f"; done
EOF

# Run project post_start.sh if exists
for f in /workspaces/*/post_start.sh; do [ -x "$f" ] && "$f"; done
