#!/usr/bin/env bash

# Create symbolic links
ln -s $(realpath ./mydotfiles/.gitconfig) ~/.gitconfig
ln -s $(realpath ./mydotfiles/.gitconfig-personal) ~/.gitconfig-personal
ln -s $(realpath ./mydotfiles/vim/.vimrc) ~/.vimrc
