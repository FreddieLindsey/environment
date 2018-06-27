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

notify-start "JENV VERSIONS"
for i in $(ls /Library/Java/JavaVirtualMachines/); do 
  jenv add "/Library/Java/JavaVirtualMachines/${i}/Contents/Home"
done
notify-end "JENV VERSIONS"

PYENV_VERSIONS=(
  $(pyenv install -l | sed -e 's/^[ \t]*//' | egrep '^2(\d)*(\.(\d)*)+$' | tail -n 1)
  $(pyenv install -l | sed -e 's/^[ \t]*//' | egrep '^3(\d)*(\.(\d)*)+$' | tail -n 1)
)
for i in "${PYENV_VERSIONS[@]}"; do
  notify-start "PYTHON $i"
  pyenv install "$i"
  notify-end "PYTHON $i"
done

NVM_LTS_VERSIONS=$(nvm ls-remote | sed -e 's/^[ \t]*//' | egrep '^v' | grep "Latest" | awk -F ' ' '{print $1}')
for i in "${NVM_LTS_VERSIONS[@]}"; do
  notify-start "NVM LTS $i"
  nvm install "$i"
  notify-end "NVM LTS $i"
done

NVM_LATEST_VERSION=$(nvm ls-remote | sed -e 's/^[ \t]*//' | egrep '^v(\d)*(\.(\d)*)*$' | tail -n 1)
notify-start "NVM LATEST $NVM_LATEST_VERSION"
nvm install $NVM_LATEST_VERSION
notify-end "NVM LATEST $NVM_LATEST_VERSION"
