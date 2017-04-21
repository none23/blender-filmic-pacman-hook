#!/bin/sh

# set path to local filmic-blender repo
REPO_URL='https://github.com/sobotka/filmic-blender'
LOCAL_PATH=${1-/opt/filmic-blender}

cd /usr/share/blender/*/datafiles || exit 1

if [ ! -d "$LOCAL_PATH" ]; then
    sudo mkdir -p "$LOCAL_PATH" || echo "$LOCAL_PATH exists - using it"
    git clone "$REPO_URL" "$LOCAL_PATH" 2> /dev/null || sudo git clone "$REPO_URL" "$LOCAL_PATH"
fi

[ -e ./colormanagement.bkp ] && sudo rm -rf ./colormanagement.bkp
[ -e ./colormanagement ] && sudo mv colormanagement colormanagement.bkp

# symlink colormanagement to filmic blender git repo
sudo ln -s "$LOCAL_PATH" ./colormanagement

# pull the filmic-blender repo
cd ./colormanagement || exit 1
git pull origin master 2> /dev/null || sudo git pull origin master
