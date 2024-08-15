#!/bin/sh
# Sync changed files to repo
# MUST be executed from current script direcotry

rsync / ~/.local/src/dt/ditatompel/machines/p50/ --include-from ./rsync-include -avh
