# MoltyDAO Development Environment
# Foundry + Node.js for full-stack development

FROM ghcr.io/foundry-rs/foundry:latest

USER root

# Install Node.js (for backend services)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
WORKDIR /workspace

# Copy project files
COPY . .

# Install Forge dependencies
RUN forge install --no-commit OpenZeppelin/openzeppelin-contracts || true

# Build contracts
RUN forge build || true

# Default command
CMD ["tail", "-f", "/dev/null"]
