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

VSCODE_EXTENSIONS=(
	"james-yu.latex-workshop" "timonwong.shellcheck" "hnw.vscode-auto-open-markdown-preview"
	"eg2.tslint" "2gua.rainbow-brackets" "WakaTime.vscode-wakatime" "shinnn.stylelint"
  "Zignd.html-css-class-completion" "ms-vscode.Go" "redhat.java" "vscjava.vscode-java-debug"
  "vscjava.vscode-maven" "shyykoserhiy.vscode-spotify" "wart.ariake-dark"
  "akamud.vscode-theme-onedark" "akamud.vscode-theme-onelight" "wesbos.theme-cobalt2"
  "robertohuertasm.vscode-icons"
)
for i in "${VSCODE_EXTENSIONS[@]}"; do
  notify-start "$(echo "VSCODE EXTENSION $i" | awk '{print toupper($0)}')"
  code --install-extension "$i"
  notify-end "$(echo "VSCODE EXTENSION $i" | awk '{print toupper($0)}')"
done
