#!/bin/sh
echo -ne '\033c\033]0;IMD Party\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/IMD Party.x86_64" "$@"
