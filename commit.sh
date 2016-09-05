#!/usr/bin/env bash

git pull
homesick symlink home-files
vim +PluginInstall +qall
cd .
git add -A .
git commit -m "Update dotfiles."
git push

