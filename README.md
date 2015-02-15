MyDotFiles
==========

This project is basically to track my personal configurations across my multiples enviroments.

Installing
----------

Make a clone of this repository:
```
$ git clone git@github.com:bcfurtado/mydotfiles.git ~/Projects/mydotfiles
```

After that, you will need create a simbolic link to vim configuration file and his folder:

```
$ ln -s ~/documents/mydotfiles/vim/.vimrc ~/.vimrc
```
```
$ ln -s ~/documents/mydotfiles/vim/.vim/ ~/.vim
```

After that, you will need install the plugins missing that are managed by Vundler.vim using ````:PluginInstall``` on vim.

And we finished! :)

