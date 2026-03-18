# deviron

A containerized development environment based on Debian, managed via devcontainer CLI.

## What's Inside

| Tool | Version | Source |
|------|---------|--------|
| Go | 1.26.1 | go.dev |
| Node.js | 24.14.0 | nodejs.org |
| Neovim | 0.11.6 | GitHub releases |
| lazygit | 0.60.0 | GitHub releases |
| tree-sitter-cli | latest | npm |

Also includes: zsh, git, curl, stow, build-essential, openssh-client.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [devcontainer CLI](https://github.com/devcontainers/cli) (`npm install -g @devcontainers/cli`)
- [just](https://github.com/casey/just)
- Host `~/.gitconfig` and `~/.ssh` configured (mounted into the container)

## Usage

```bash
just devup       # build and start the container
just devin       # open a zsh shell inside the container
just devin nvim  # run a specific command
just devdown     # stop and remove the container
just dev         # devdown + devup + devin
```
