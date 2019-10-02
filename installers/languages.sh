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

JABBA_VERSIONS=(
  $(jabba ls-remote | sed -e 's/^[ \t]*//' | egrep '^zulu@1.8(.[[:digit:]]+)+$' | head -n 1)
  $(jabba ls-remote | sed -e 's/^[ \t]*//' | egrep '^zulu@1.11(.[[:digit:]]+)+$' | head -n 1)
)
for i in "${JABBA_VERSIONS[@]}"; do
  notify-start "JABBA VERSION: $i"
  jabba install $i
  notify-end "JABBA VERSION: $i"
done
jabba alias default ${JABBA_VERSIONS[1]}

PYENV_VERSIONS=(
  $(pyenv install -l | sed -e 's/^[ \t]*//' | egrep '^2(.[[:digit:]]+)+$' | tail -n 1)
  $(pyenv install -l | sed -e 's/^[ \t]*//' | egrep '^3(.[[:digit:]]+)+$' | tail -n 1)
)
for i in "${PYENV_VERSIONS[@]}"; do
  notify-start "PYTHON $i"
  pyenv install $i
  notify-end "PYTHON $i"
done

. "$(brew --prefix nvm)/nvm.sh"
LTS_VERSIONS=3
NVM_LTS_VERSIONS=(
  $(nvm ls-remote --lts | grep "Latest" | \
  sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g' | sed -e 's/^[->| |\t]*//' | \
  sed -e 's/v//g' | awk -F ' ' '{print $1}' | tail -n 3)
)
for i in "${NVM_LTS_VERSIONS[@]}"; do
  notify-start "NVM LTS $i"
  nvm install $i
  notify-end "NVM LTS $i"
done

NVM_LATEST_VERSION=$(nvm ls-remote | sed -e 's/^[ \t]*//' | egrep '^v[[:digit:]]*(.[[:digit:]]*)*$' | tail -n 1)
notify-start "NVM LATEST $NVM_LATEST_VERSION"
nvm install $NVM_LATEST_VERSION
notify-end "NVM LATEST $NVM_LATEST_VERSION"
