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
cp files/vscode-settings.json ~/Library/Application\ Support/Code/User/settings.json
notify-end "VSCODE CONFIG"

VSCODE_EXTENSIONS=("james-yu.latex-workshop" "timonwong.shellcheck")
for i in "${VSCODE_EXTENSIONS[@]}"; do
  notify-start "$(echo "VSCODE EXTENSION $i" | awk '{print toupper($0)}')"
  code --install-extension "$i"
  notify-end "$(echo "VSCODE EXTENSION $i" | awk '{print toupper($0)}')"
done

