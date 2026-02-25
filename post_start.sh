#!/usr/bin/env bash
set -e

D="/workspace/.dotfiles"
H="/home/vscode"

# Directories
for f in .claude .codex .cursor .gemini .kube .mcp-auth; do
    [ -d "$D/$f" ] && ln -sfn "$D/$f" "$H/$f"
done

# Files
for f in .claude.json .env .zsh_history; do
    [ -f "$D/$f" ] && ln -sf "$D/$f" "$H/$f"
done

# Git config include
[ -f "$D/.gitconfig" ] || touch "$D/.gitconfig"
git config --global include.path "$D/.gitconfig"
