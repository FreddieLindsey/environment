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
BREWS=(
  pyenv pyenv-virtualenv rbenv nvm jenv ranger tmux shellcheck readline xz reattach-to-user-namespace
  # GNU utils
  coreutils binutils diffutils "ed --with-default-names" "findutils --with-default-names"
  gawk "gnu-indent --with-default-names" "gnu-sed --with-default-names" "gnu-tar --with-default-names"
  "gnu-which --with-default-names" gnutls "grep --with-default-names" gzip screen watch "wdiff --with-gettext" wget
  # Updated system utils
  bash emacs gdb gpatch less m4 make nano file-formula git openssh perl python rsync svn unzip
  "vim --override-system-vi" zsh
)
for i in "${BREWS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "brew install $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Tap other casks
CASKS=("homebrew/cask-fonts" "homebrew/cask-versions")
for i in "${CASKS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "brew tap $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done

# Install cask brews
CASK_BREWS=(
    iterm2 font-source-code-pro-for-powerline font-fira-code docker
    mactex-no-gui java java8 java6 intellij-idea visual-studio-code google-chrome
    virtualbox vlc
)
for i in "${CASK_BREWS[@]}"; do
  notify-start "$(echo CASK\ $i | awk '{print toupper($0)}')"
  eval "brew cask install $i"
  notify-end "$(echo CASK\ $i | awk '{print toupper($0)}')"
done
