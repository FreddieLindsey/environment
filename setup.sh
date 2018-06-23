#!/bin/bash

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install normal brews
brew install mas

# Install cask brews
brew cask install iterm2
brew cask install visual-studio-code
brew cask install google-chrome
brew cask install spotify

# Install apps from Mac App Store
mas install "$(mas search Moom | head -n 1 | awk -F ' ' '{print $1}')"
mas install "$(mas search ScanSnap\ Cloud | head -n 1 | awk -F ' ' '{print $1}')"
mas install "$(mas search Slack | head -n 1 | awk -F ' ' '{print $1}')"
mas install "$(mas search Wunderlist | head -n 1 | awk -F ' ' '{print $1}')"
mas install 446107677 # Screens 3
