#!/bin/sh

for file in "$@"; do
  case "$file" in
    *.watched)
      mv -- "$file" "${file%.watched}"
      ;;
    *)
      mv -- "$file" "${file}.watched"
      ;;
  esac
done
