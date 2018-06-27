#!/bin/zsh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

notify () {
  echo -e "--------------------------------------------------------------------------"
  echo -e "--- $1"
  echo -e "--------------------------------------------------------------------------"
}

notify-start () {
  notify "INSTALLING $1"
}

notify-end () {
  notify "INSTALLED $1"
  echo -e "\n"
}

# Install homebrew
notify-start "HOMEBREW"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
notify-end "HOMEBREW"

# Install normal brews
BREWS=(mas pyenv pyenv-virtualenv rbenv nvm jenv)
for i in "${BREWS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  brew install "$i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Tap other casks
CASKS=("homebrew/cask-fonts" "homebrew/cask-versions")
for i in "${CASKS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  brew tap "$i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Install cask brews
CASK_BREWS=(
    bartender istat-menus iterm2 font-source-code-pro-for-powerline font-fira-code
    mactex-no-gui java java8 java6 intellij-idea visual-studio-code google-chrome
    spotify virtualbox vlc
)
for i in "${CASK_BREWS[@]}"; do
  notify-start "$(echo CASK\ $i | awk '{print toupper($0)}')"
  brew cask install "$i"
  notify-end "$(echo CASK\ $i | awk '{print toupper($0)}')"
done

# Install apps from Mac App Store
MAS_APPS_AUTO=(Moom ScanSnap\ Cloud Slack Spark WhatsApp\ Desktop Wunderlist)
for i in "${MAS_APPS_AUTO[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  mas install "$(mas search "$i" | head -n 1 | awk -F ' ' '{print $1}')"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

MAS_APPS_MANUAL=(446107677)
for i in "${MAS_APPS_MANUAL[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  mas install "$i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done
