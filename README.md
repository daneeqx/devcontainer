# Devcontainers

Development container configuration based on Ubuntu 24.04 with a modular feature system for full-stack development.

## Quick Start

1. Open the repository in VS Code
2. When prompted, click **Reopen in Container** (or run `Dev Containers: Reopen in Container` from the command palette)
3. The container will build and configure all tools automatically

## What's Included

### Base Image

Ubuntu 24.04 with essential system packages: `curl`, `git`, `jq`, `vim`, `wget`, `unzip` and others.

### Languages & Runtimes

| Tool       | Version |
|------------|---------|
| Go         | 1.26.0  |
| Python     | 3.14.3  |
| Node.js    | latest  |

### Infrastructure Tools

| Tool                      | Description                    |
|---------------------------|--------------------------------|
| Docker-in-Docker          | Build and run containers       |
| kubectl / Helm / Minikube | Kubernetes development         |
| AWS CLI                   | AWS cloud management           |
| K6                        | Load testing                   |
| Protobuf                  | Protocol Buffers (VS Code ext) |

### VS Code Extensions

Go, Python, Docker, Kubernetes, GitLens, Git Blame, Git History, REST Client, Rainbow CSV, YAML, Markdown Lint, Error Lens, EditorConfig, npm IntelliSense, Claude Code, GitHub Copilot.

## Architecture

The configuration uses a layered feature system under `.devcontainer/features/`:

```
.devcontainer/
├── Dockerfile                  # Base Ubuntu 24.04 image
├── devcontainer.json           # Main config, mounts, extensions
├── setup/common/               # Meta-feature aggregating all features
│   └── devcontainer-feature.json
└── features/
    ├── base/          # Foundation: zsh, system packages, netrc, gitconfig
    ├── go/            # Go 1.26.0
    ├── python/        # Python 3.14.3
    ├── nodejs/        # Node.js
    ├── dind/          # Docker-in-Docker
    ├── git/           # Git
    ├── k6/            # K6 load testing
    ├── ssh/           # SSH keys (persistent)
    ├── aws/           # AWS CLI + persistent config
    ├── kubectl-helm-minikube/  # Kubernetes tools + persistent config
    ├── protobuf/      # Protobuf VS Code extension
    └── dotfiles/      # Shell config system (.zshrc.d)
```

Features are split into three categories:

- **Language wrappers** (`go`, `python`, `nodejs`) — thin wrappers around official devcontainer features with pinned versions
- **Infrastructure** (`dind`, `git`, `k6`, `protobuf`) — tool installation without extra config
- **Stateful** (`ssh`, `aws`, `kubectl-helm-minikube`) — depend on `dotfiles` and use symlinks into `/workspace/.dotfiles/` so credentials and configs persist across container rebuilds

## Persistent Storage

The `workspace/` directory is bind-mounted to `/workspace` inside the container. All persistent state lives in `/workspace/.dotfiles/`:

| Path                        | Purpose                  |
|-----------------------------|--------------------------|
| `.dotfiles/.ssh/`           | SSH keys                 |
| `.dotfiles/.aws/`           | AWS credentials & config |
| `.dotfiles/.kube/`          | Kubernetes config        |
| `.dotfiles/.gitconfig`      | User git config          |
| `.dotfiles/.zshrc.d/*.sh`   | Shell customization      |

The host `~/.ssh` directory is also bind-mounted for immediate SSH access.

## Shell Environment

Zsh is the default shell, configured with:

- **Aliases** — shortcuts for git (`g`, `gs`, `gc`, `gp`...), docker (`d`, `dc`, `dps`...), kubectl (`k`, `kg`, `kd`...), navigation (`..`, `ll`, `la`)
- **Functions** — `mkcd`, `extract` (any archive), `serve` (HTTP server), `port` (find process by port), `dsh` (shell into container), `gca` (git add + commit)
- **History** — 50,000 entries, shared across sessions, no duplicates
- **Completion** — case-insensitive, menu-style

Shell customization files go into `workspace/.dotfiles/.zshrc.d/` — any `*.sh` file there is sourced automatically on shell startup.

## Post-Start Hooks

On container start, `post_start.sh` runs and symlinks persistent dotfiles (`.claude`, `.kube`, `.env`, `.zsh_history`, etc.) from `/workspace/.dotfiles/` into the home directory.

## Customization

**Add a shell alias or function:** create a new `.sh` file in `workspace/.dotfiles/.zshrc.d/`.

**Add a new tool:** create a feature directory under `.devcontainer/features/` with `devcontainer-feature.json` and `install.sh`, then add it to `setup/common/devcontainer-feature.json`.

**Change tool versions:** edit the `version` field in the corresponding feature's `devcontainer-feature.json`.

## GitLab Integration (Optional)

The `base` feature supports optional GitLab configuration for git URL rewriting and `.netrc` authentication. Pass the options through `setup/common` in `devcontainer.json`:

```json
"features": {
    "./setup/common": {
        "gitlabDomain": "gitlab.example.com",
        "gitlabUsername": "your-username",
        "gitlabToken": "glpat-xxxxxxxxxxxx"
    }
}
```

When provided, this will:
- Configure git to rewrite `https://gitlab.example.com/` URLs to `git@gitlab.example.com:` (SSH)
- Create `/etc/.netrc` with credentials for `go get`, `pip install`, and other tools that use netrc authentication

When omitted, no GitLab configuration is written.

@daneeqx
