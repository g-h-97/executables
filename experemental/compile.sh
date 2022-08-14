#!/bin/sh
# General handler for compiling files

file=$(readlink -f "$1")
base=$(echo "$file" | sed 's/\..*//')

handlebang() {
  bang=$(head -n 1 "$file")
  case "$bang" in
    *!/bin/sh|*!/bin/bash|*!/bin/zsh) "$file" ;;
    *!/bin/perl) perl "$file" ;;
    *!/bin/python) python "$file" ;;
    *) echo "Can't compile" ;;
  esac
}

case "$1" in
    *.md) pandoc --filter pandoc-crossref "$file" -o "$base".pdf --from markdown+pipe_tables;;
    *.py) python "$file" ;;
    *.perl) perl "$file" ;;
    *) handlebang ;;
esac
