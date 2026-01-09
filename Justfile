#!/usr/bin/env just --working-directory . --justfile

import "tmux.just"
import "browser.just"
import "aws.just"
import "terraform.just"
import "copier.just"

default:
	@just -f {{justfile()}} --list

info:
	@echo "Running just from $PWD"
