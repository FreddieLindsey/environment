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

PATH="$(brew --prefix jenv):$PATH"
eval "$(jenv init -)"
for i in $(ls /Library/Java/JavaVirtualMachines/); do
  notify-start "JENV VERSION: $i"
  eval "jenv add /Library/Java/JavaVirtualMachines/${i}/Contents/Home"
  notify-end "JENV VERSION: $i"
done

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
NVM_LTS_VERSIONS=(
  $(nvm ls-remote | sed -e 's/^[ \t]*//' | egrep '^v' | sed -e 's/v//g' | grep "Latest" | awk -F ' ' '{print $1}')
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
