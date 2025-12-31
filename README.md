# Justfiles

This repository contains [Just](https://github.com/casey/just) recipes which i often use.

## Install as default Justfile

You can make these recipes your user default by symlinking the repo's `Justfile` into your home directory. Replace the path with wherever you cloned this repo.

```bash
git clone git@github.com:timvw/justfiles.git ~/dev/github/justfiles
cd ~/dev/github/justfiles
ln -s "$PWD/Justfile" "$HOME/.Justfile"
```

Notes:
- `just` treats Justfile names case-insensitively, so `$HOME/.Justfile` works the same as `$HOME/.justfile`.
- If you prefer, use another supported location (for example `$HOME/justfile`).
- See the Justfile discovery rules in the Just manual: https://just.systems/man/en/quick-start.html
