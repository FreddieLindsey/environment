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

# Install normal brews
BREWS=()
for i in "${BREWS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "brew install $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Tap other casks
CASKS=()
for i in "${CASKS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "brew tap $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Install cask brews
CASK_BREWS=(
    1password bartender istat-menus spotify
)
for i in "${CASK_BREWS[@]}"; do
  notify-start "$(echo CASK\ $i | awk '{print toupper($0)}')"
  eval "brew cask install $i"
  notify-end "$(echo CASK\ $i | awk '{print toupper($0)}')"
done

# Install apps from Mac App Store
MAS_APPS_AUTO=(Moom ScanSnap\ Cloud Spark WhatsApp\ Desktop Wunderlist)
for i in "${MAS_APPS_AUTO[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  mas install "$(mas search "$i" | head -n 1 | awk -F ' ' '{print $1}')"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done
