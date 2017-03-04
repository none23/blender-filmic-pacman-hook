#!/bin/zsh

# set path to local filmic-blender repo
FILMIC_BLENDER_LOCAL_PATH=${1-/opt/filmic-blender}

# clone filmic-blender if local repo doesn't exist
[[ -d $FILMIC_BLENDER_LOCAL_PATH ]] || (mkdir -p $FILMIC_BLENDER_LOCAL_PATH && git clone https://github.com/sobotka/filmic-blender $FILMIC_BLENDER_LOCAL_PATH);

# cd into blender datafiles directory
cd /usr/share/blender/*/datafiles;

# remove colormanagement.bkp if it exists; backup colormanagement directory
[[ -a ./colormanagement.bkp ]] && rm -rf ./colormanagement.bkp;
[[ -a ./colormanagement ]] && mv colormanagement{,.bkp};

# symlink colormanagement to filmic blender git repo
ln -s $FILMIC_BLENDER_LOCAL_PATH ./colormanagement;

# pull the filmic-blender repo
cd ./colormanagement;
git pull origin master;
