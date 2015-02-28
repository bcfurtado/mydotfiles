MyDotFiles
==========

This project is basically to track my personal configurations across my multiples enviroments.

Requirements
------------
AG - The Silver Searcher: https://github.com/ggreer/the_silver_searcher 

Installing
----------

Make a clone of this repository:
```
$ git clone git@github.com:bcfurtado/mydotfiles.git ~/Projects/mydotfiles
```
Enter in the project folder and make a download of all submodules:
```
$ git submodule init && git submodule update && git submodule status
```

After that, you will need create a simbolic link to vim configuration file and his folder:

```
$ ln -s ~/documents/mydotfiles/vim/.vimrc ~/.vimrc
```
```
$ ln -s ~/documents/mydotfiles/vim/.vim/ ~/.vim
```

After that, you will need install the plugins missing that are managed by Vundler.vim using ```:PluginInstall``` on vim.

And we finished! :)

