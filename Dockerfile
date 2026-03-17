FROM debian:bookworm-slim

ARG GO_VERSION=1.26.1
ARG NODE_VERSION=24.14.0
ARG NEOVIM_VERSION=0.11.6
ARG LAZYGIT_VERSION=0.60.0

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  git \
  stow \
  zsh \
  curl \
  xz-utils \
  && rm -rf /var/lib/apt/lists/*

# Go — from go.dev
RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" \
  | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Node.js — from nodejs.org
RUN curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" \
  | tar -C /usr/local --strip-components=1 -xJ

# tree-sitter-cli — required by nvim-treesitter (LazyVim)
RUN npm install -g tree-sitter-cli

# Neovim — from GitHub releases
RUN curl -fsSL -o /tmp/nvim.tar.gz \
  "https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim-linux-x86_64.tar.gz" \
  && tar -C /usr/local --strip-components=1 -xzf /tmp/nvim.tar.gz \
  && rm /tmp/nvim.tar.gz

# lazygit — from GitHub releases
RUN curl -fsSL -o /tmp/lazygit.tar.gz \
  "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
  && tar -C /tmp -xzf /tmp/lazygit.tar.gz lazygit \
  && install /tmp/lazygit /usr/local/bin \
  && rm /tmp/lazygit /tmp/lazygit.tar.gz

# Create a new user named 'dev'
# -m: creates the home directory
# -s /bin/zsh: sets their default shell to zsh
RUN useradd -m -s /bin/zsh dev

# Switch from root to the new 'dev' user
USER dev

# Make go binaries installed via `go install` available
ENV PATH="/home/dev/go/bin:${PATH}"

# Set the starting directory to the new user's home folder
WORKDIR /home/dev

CMD ["zsh"]
