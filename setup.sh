#!/bin/bash

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

# Increase maxfiles and maxprocesses limits
PLIST_FILES=("limit.maxfiles.plist" "limit.maxproc.plist")
for i in "${PLIST_FILES[@]}"; do
  notify-start "$(echo "LAUNCH FILE $i" | awk '{print toupper($0)}')"
  sudo cp ./files/${i} /Library/LaunchDaemons
  sudo chown root:wheel /Library/LaunchDaemons/${i}
  sudo launchctl unload -w /Library/LaunchDaemons/${i} >/dev/null 2>&1
  sudo launchctl load -w /Library/LaunchDaemons/${i}
  notify-end "$(echo "LAUNCH FILE $i" | awk '{print toupper($0)}')"
done

# Brew
./installers/brew.sh
./installers/brew_tools.sh
# ./installers/brew_desktop.sh

# Shell
./installers/zprezto.sh

# Install latest node, ruby, python, and java (symlinks)
./installers/languages.sh

# Install extensions for VSCode
./installers/vscode_extensions.sh

# Install Docker images
./installers/docker_defaults.sh

# Install settings files
./installers/settings.sh
