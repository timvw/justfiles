# Justfiles

This repository contains some frequently used [Just](https://github.com/casey/just) recipes.

## Getting started

Clone the repository and use the recipes as following:


```bash
# Assuming that you cloned the repo in $HOME/src/justfiles

# Invoke just, provide the justfile and working directory
just --justfile $HOME/src/justfiles/Justfile --working-directory .

# In case you want to use it all the time, export JUST_JUSTFILE
JUST_JUSTFILE=$HOME/src/justfiles/Justfile
just --working-directory .

# Or define an alias and invoke the alias
alias jg='just --justfile $HOME/src/justfiles/Justfile --working-directory .'
jg

# Or invoke it as a script
$HOME/src/justfiles/Justfile
```
