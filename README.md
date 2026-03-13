.dot-files
==========

This project tracks my personal configurations across multiple environments.

## Installing

Clone the repository:

```sh
$ mkdir -p ~/projects/github.com/bcfurtado && cd $_
$ git clone git@github.com:bcfurtado/mydotfiles.git
```

Install brew packages

```sh
$ brew bundle install --file=Brewfile
```

Create symbolic links:

```sh
$ ln -s $(realpath ./mydotfiles/.gitconfig) ~/.gitconfig
$ ln -s $(realpath ./mydotfiles/.gitconfig-personal) ~/.gitconfig-personal
$ ln -s $(realpath ./mydotfiles/vim/.vimrc) ~/.vimrc
```

