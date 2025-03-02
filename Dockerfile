# Build stage
FROM debian:bookworm-slim

# Install required packages and ast-grep 0.35.0
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates unzip && \
    case $(uname -m) in \
    x86_64) ARCH="x86_64";; \
    aarch64) ARCH="aarch64";; \
    *) echo "Unsupported architecture" && exit 1;; \
    esac && \
    curl -L "https://github.com/ast-grep/ast-grep/releases/download/0.35.0/app-$ARCH-unknown-linux-gnu.zip" -o /tmp/sg.zip && \
    unzip /tmp/sg.zip -d /usr/local/bin && \
    rm /tmp/sg.zip && \
    apt-get purge -y curl unzip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*