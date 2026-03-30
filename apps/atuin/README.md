# Atuin

[Atuin](https://atuin.sh) replaces shell history with a SQLite database, providing full-text search, timestamps, exit codes, and optional sync across machines.

## Useful commands

### Import existing history

Reads from your existing history file (e.g., `~/.zsh_history`) and imports it into Atuin's SQLite database.

```sh
atuin import zsh
# or auto-detect shell
atuin import auto
```

### Search history

```sh
atuin search <query>
# or press Ctrl+R in the shell
```

### Stats

```sh
atuin stats
```
