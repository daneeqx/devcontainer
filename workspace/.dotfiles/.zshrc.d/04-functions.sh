# Create directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Find process by name
psg() { ps aux | grep -v grep | grep -i "$1"; }

# Quick HTTP server in current dir
serve() { python3 -m http.server "${1:-8080}"; }

# Show who listens on a port
port() { lsof -i :"$1" 2>/dev/null || ss -tlnp | grep "$1"; }

# Extract any archive
extract() {
    [ ! -f "$1" ] && echo "File not found: $1" && return 1
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.tar.xz)  tar xJf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.zip)     unzip "$1" ;;
        *.7z)      7z x "$1" ;;
        *)         echo "Unknown format: $1" ;;
    esac
}

# Git: quick commit with message
gca() { git add -A && git commit -m "$*"; }

# Docker: shell into container
dsh() { docker exec -it "$1" sh -c 'command -v bash >/dev/null && exec bash || exec sh'; }
