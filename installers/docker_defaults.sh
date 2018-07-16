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
DOCKER_IMAGES=("postgres:10" "postgres:9" "ubuntu:14.04" "ubuntu:16.04" "ubuntu:18.04")
for i in "${BREWS[@]}"; do
  notify-start "$(echo $i | awk '{print toupper($0)}')"
  eval "docker pull $i"
  notify-end "$(echo $i | awk '{print toupper($0)}')"
done