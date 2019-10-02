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
which brew >/dev/null 2>&1
if [[ $? != 0 ]]; then
  notify-start "HOMEBREW"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  notify-end "HOMEBREW"
fi

# Install normal brews
BREWS=(
  pyenv pyenv-virtualenv rbenv nvm jabba
  ranger tmux shellcheck readline xz reattach-to-user-namespace
)
for i in "${BREWS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "brew install $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Tap other casks
CASKS=(
  'homebrew/cask-fonts'
)
for i in "${CASKS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "brew tap $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Install cask brews
CASK_BREWS=(
    1password bartender docker font-source-code-pro-for-powerline font-fira-code
    jetbrains-toolbox istat-menus iterm2 signal spotify visual-studio-code whatsapp
)
for i in "${CASK_BREWS[@]}"; do
  notify-start "$(echo CASK\ $i | awk '{print toupper($0)}')"
  eval "brew cask install $i"
  notify-end "$(echo CASK\ $i | awk '{print toupper($0)}')"
done
