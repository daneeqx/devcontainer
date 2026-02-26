#!/usr/bin/env bash
set -e

CONFIG="/workspace/.dotfiles"
USER_HOME="/home/vscode"

# Link .gitconfig
ln -sf "$CONFIG/.gitconfig" "$USER_HOME/.gitconfig"

# Create directories (.ssh is mounted from host)
mkdir -p "$CONFIG/.zshrc.d"

# Create default zshrc.d example if empty
[ -d "$CONFIG/.zshrc.d" ] && [ -z "$(ls -A "$CONFIG/.zshrc.d")" ] && \
    echo "# Add your custom shell config here" > "$CONFIG/.zshrc.d/00-example.sh"

# Add zshrc.d sourcing (idempotent)
grep -q "zshrc.d" "$USER_HOME/.zshrc" 2>/dev/null || cat >> "$USER_HOME/.zshrc" << 'EOF'

# Source user scripts
for f in /workspace/.dotfiles/.zshrc.d/*.sh(N); do source "$f"; done
EOF


# Run project post_start.sh if exists
for f in /workspaces/*/post_start.sh; do [ -f "$f" ] && bash "$f"; done
