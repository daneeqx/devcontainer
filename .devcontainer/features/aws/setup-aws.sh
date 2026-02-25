#!/usr/bin/env bash
set -e

DOTFILES="/workspace/.dotfiles"

# Create .aws directory and symlink
mkdir -p "$DOTFILES/.aws"
ln -sfn "$DOTFILES/.aws" /home/vscode/.aws

echo "✓ AWS directory ready at $DOTFILES/.aws"
