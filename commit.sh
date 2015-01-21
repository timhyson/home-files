#!/usr/bin/env bash

git pull
homesick symlink home-files
vim +PluginInstall +qall
cd .
git add .
git commit -m "Updates dotfiles"
git push

