#!/usr/bin/env bash
set -e

DOTFILES="/workspace/.dotfiles"

# Create .kube directory and symlink
mkdir -p "$DOTFILES/.kube"
ln -sfn "$DOTFILES/.kube" /home/vscode/.kube

echo "✓ Kube directory ready at $DOTFILES/.kube"
