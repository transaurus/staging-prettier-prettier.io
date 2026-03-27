#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for prettier/prettier.io
# Runs from website/ in existing source tree (no clone).
# Installs deps and builds the Docusaurus site.

# --- Node version ---
# Requires Node 22+ (package-dependencies-tree uses findPackageJSON from node:module)
NODE22_PATH="/opt/hostedtoolcache/node/22.22.1/x64/bin"
if [ -d "$NODE22_PATH" ]; then
    export PATH="$NODE22_PATH:$PATH"
else
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    if [ ! -d "$NVM_DIR" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
    fi
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 22
    nvm use 22
fi
echo "[INFO] Node: $(node --version)"

# --- Package manager: Yarn 4 via corepack ---
corepack enable
echo "[INFO] Yarn: $(yarn --version)"

# --- Install dependencies ---
yarn install

# --- Build Docusaurus site ---
yarn build

echo "[DONE] Build complete."
