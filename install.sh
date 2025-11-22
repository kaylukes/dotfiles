#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Detecting distro ==="
if command -v pacman >/dev/null 2>&1; then
    DISTRO="arch"
elif command -v apt >/dev/null 2>&1; then
    DISTRO="debian"
else
    echo "Unsupported system. Only Arch and Ubuntu/Debian are supported."
    exit 1
fi
echo "Detected: $DISTRO"

echo "=== Installing dependencies: zsh, ripgrep, build tools ==="
if [ "$DISTRO" = "arch" ]; then
    sudo pacman -Syu --needed zsh ripgrep base-devel cmake ninja curl git
else
    sudo apt update
    sudo apt install -y zsh ripgrep build-essential cmake ninja-build curl git
fi

echo "=== Installing Neovim 0.11.5 from source ==="
NVIM_VERSION="0.11.5"

# Skip if already installed with correct version
if command -v nvim >/dev/null && nvim --version | grep -q "NVIM v$NVIM_VERSION"; then
    echo "Neovim $NVIM_VERSION already installed, skipping..."
else
    cd /tmp
    rm -rf neovim
    git clone --depth 1 --branch "v$NVIM_VERSION" https://github.com/neovim/neovim.git
    cd neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
fi

echo "=== Installing oh-my-zsh (if not installed) ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed."
fi

echo "=== Copying zsh configuration ==="
cp "$REPO_DIR/zsh/.zshrc" "$HOME/.zshrc"
cp -r "$REPO_DIR/zsh/theme/"* "$HOME/.oh-my-zsh/themes/"

echo "=== Copying Neovim config ==="
mkdir -p "$HOME/.config/nvim"
cp -r "$REPO_DIR/nvim/"* "$HOME/.config/nvim/"

echo "=== Changing default shell to zsh (if not already) ==="
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi

echo "=== DONE! ==="
echo "Restart your terminal to apply settings."
