##!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"

# check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# update homebrew
brew update
echo "Update homebrew..."


info_echo "Installing or updating chezmoi ..."
brew bundle --file=- <<EOF
    brew 'chezmoi'
EOF

if [ ! -f "$HOME/.config/chezmoi/chezmoi.toml" ]; then
  info_echo "Applying dotfiles with chezmoi ..."
  chezmoi init --apply --verbose https://github.com/phongnguyen93/dotfiles.git
  chmod 0600 "$HOME/.config/chezmoi/chezmoi.toml"
fi