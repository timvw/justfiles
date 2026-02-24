#!/usr/bin/env just --working-directory . --justfile

set dotenv-load := true

instance := env_var_or_default("INSTANCE", env_var_or_default("ENVIRONMENT", "dev"))
default_env_part := replace_regex(instance, ".*-", "")
default_env := if default_env_part == "" { "dev" } else { default_env_part }
env := env_var_or_default("ENVIRONMENT", default_env)

import "tmux.just"
import "browser.just"
import "aws.just"
import "terraform.just"
import "copier.just"

default:
	@just -f {{justfile()}} --list

info:
	@echo "Running just from $PWD"
	@echo "To see the value of a variable, run just --evaluate variable_name, eg: just --evaluate env"
