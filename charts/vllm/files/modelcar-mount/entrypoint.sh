#!/bin/bash

set -euo pipefail

function noisy {
    set -x
    "${@}"
    { set +x; } 2>/dev/null
}

while [ "${#@}" -gt 0 ]; do
    case "$1" in
    mount)
        shift
        destDir="${1}"
        ;;
    check)
        if [ -d /models ] && [ "$(ls -A /models)" ]; then
            echo "/models directory exists"
            exit 0
        else
            echo "/models directory does not exist or is empty" >&2
            exit 1
        fi
        ;;
    *)
        echo "Unexpected arg: $1" >&2
        exit 1
        ;;
    esac
    shift
done

# Symlink model files
for file in /proc/$$/root/models/*; do
    dest="${destDir}/$(echo "$file" | cut -d/ -f6-)"
    noisy ln -sf "$file" "$dest"
done

# Hold process open so procfs stays
noisy sleep infinity
