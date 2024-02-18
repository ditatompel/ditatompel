#!/bin/sh
# Sync changed files to repo
# MUST be executed from current script direcotry

rsync / ~/.local/src/ditatompel/machines/hpg7/ --include-from ./rsync-include -avh
