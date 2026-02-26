#!/usr/bin/env bash
set -e

D="/workspace/.dotfiles"
H="/home/vscode"

# Directories
for f in .claude .codex .cursor .gemini .kube .mcp-auth; do
    [ -d "$D/$f" ] && ln -sfn "$D/$f" "$H/$f" || true
done

# Files
for f in .claude.json .env .zsh_history; do
    [ -f "$D/$f" ] && ln -sf "$D/$f" "$H/$f" || true
done

