MyDotFiles
==========

This project is basically to track my personal configurations across my multiples enviroments.

Requirements
------------
- [AG - The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
- [My emacs settings](https://github.com/bcfurtado/.emacs.d)

Installing
----------

Make a clone of this repository:
```
$ git clone git@github.com:bcfurtado/mydotfiles.git ~/workspace/mydotfiles
```
Enter in the project folder and make a download of all submodules:
```
$ git submodule init && git submodule update && git submodule status
```

After that, you will need create a simbolic link to vim configuration file and his folder:

```
$ ln -s ~/workspace/mydotfiles/vim/.vimrc ~/.vimrc
$ ln -s ~/workspace/mydotfiles/vim/.vim/ ~/.vim
```

After that, we will need install the plugins that are managed by Vundler.vim excuting ```:PluginInstall``` on vim.

And we finished! :)

