#!/usr/bin/bash -e

PROTOC_VERSION="29.3"
ARCH=$(dpkg --print-architecture)

case "$ARCH" in
    amd64) PROTOC_ARCH="linux-x86_64" ;;
    arm64) PROTOC_ARCH="linux-aarch_64" ;;
    *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
esac

curl -fsSL "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-${PROTOC_ARCH}.zip" -o /tmp/protoc.zip
unzip -o /tmp/protoc.zip -d /usr/local bin/protoc
unzip -o /tmp/protoc.zip -d /usr/local 'include/*'
rm -f /tmp/protoc.zip
chmod 755 /usr/local/bin/protoc
