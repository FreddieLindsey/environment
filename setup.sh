#!/bin/bash

notify () {
  echo -e "-------------------------------------"
  echo -e "--- $1"
  echo -e "-------------------------------------"
}

# Install homebrew
notify "INSTALLING HOMEBREW"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
notify "INSTALLED HOMEBREW"

# Install normal brews
notify "INSTALLING MAC APP STORE CLI"
brew install mas
notify "INSTALLED MAC APP STORE CLI"

# Install cask brews
notify "INSTALLING ITERM2, VISUAL STUDIO CODE, GOOGLE CHROME, SPOTIFY"
brew cask install iterm2
brew cask install visual-studio-code
brew cask install google-chrome
brew cask install spotify
notify "INSTALLED ITERM2, VISUAL STUDIO CODE, GOOGLE CHROME, SPOTIFY"

# Install apps from Mac App Store
notify "INSTALLING MOOM, SCANSNAP CLOUD, SCREENS 3, SLACK, WUNDERLIST"
mas install "$(mas search Moom | head -n 1 | awk -F ' ' '{print $1}')"
mas install "$(mas search ScanSnap\ Cloud | head -n 1 | awk -F ' ' '{print $1}')"
mas install 446107677 # Screens 3
mas install "$(mas search Slack | head -n 1 | awk -F ' ' '{print $1}')"
mas install "$(mas search Wunderlist | head -n 1 | awk -F ' ' '{print $1}')"
notify "INSTALLED MOOM, SCANSNAP CLOUD, SCREENS 3, SLACK, WUNDERLIST"
