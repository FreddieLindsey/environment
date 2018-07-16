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

notify-start "VSCODE CONFIG"
cp files/vscode-settings.json "$HOME/Library/Application Support/Code/User/settings.json"
notify-end "VSCODE CONFIG"

notify-start "ITERM CONFIG"
cp files/com.googlecode.iterm2.plist "$HOME/Documents/com.googlecode.iterm2.plist"
notify-end "ITERM CONFIG"

notify-start "TMUX CONFIG"
cp files/.tmux.conf "$HOME/.tmux.conf"
notify-end "TMUX CONFIG"
