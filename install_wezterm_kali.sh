#!/bin/bash

set -e

echo "🚀 Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing prerequisites..."
sudo apt install -y wget curl unzip git fonts-powerline

echo "🔍 Detecting system architecture..."
ARCH=$(uname -m)

echo "🖥 Architecture detected: $ARCH"

WEZTERM_CMD=""

if [[ "$ARCH" == "x86_64" ]]; then
  echo "💻 Intel/AMD system detected — installing WezTerm .deb"

  LATEST_URL=$(curl -s https://api.github.com/repos/wez/wezterm/releases/latest \
    | grep browser_download_url \
    | grep 'Ubuntu22.04.deb' \
    | cut -d '"' -f 4)

  if [[ -z "$LATEST_URL" ]]; then
    echo "Couldn't detect WezTerm .deb download link"
    exit 1
  fi

  wget "$LATEST_URL" -O /tmp/wezterm.deb
  sudo apt install -y /tmp/wezterm.deb
  WEZTERM_CMD="wezterm"

elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
  echo " ARM64 system detected — installing WezTerm AppImage"
  wget https://github.com/wez/wezterm/releases/latest/download/WezTerm.AppImage -O ~/wezterm.AppImage
  chmod +x ~/wezterm.AppImage
  WEZTERM_CMD="~/wezterm.AppImage"

else
  echo "❌ Unsupported architecture: $ARCH"
  exit 1
fi

echo "🌟 Installing Nerd Fonts..."
mkdir -p ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip -O /tmp/Meslo.zip
unzip -o /tmp/Meslo.zip -d ~/.local/share/fonts
fc-cache -fv > /dev/null

echo "🔗 Cloning your dotfiles..."
if [ ! -d "$HOME/.config/dotfiles" ]; then
  git clone https://github.com/mxhuntr/dotfiles ~/.config/dotfiles
else
  echo "✔ dotfiles already present — skipping clone"
fi

echo "🔗 Linking configurations..."
mkdir -p ~/.config
ln -sf ~/.config/dotfiles/wezterm ~/.config/wezterm
ln -sf ~/.config/dotfiles/nvim ~/.config/nvim
ln -sf ~/.config/dotfiles/tmux ~/.config/tmux

echo "✨ Installation complete!"
echo ""
echo "To start WezTerm, run:"
echo "👉 $WEZTERM_CMD"
