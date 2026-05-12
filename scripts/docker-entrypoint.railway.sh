#!/bin/sh
set -e

# Railway volumes are typically mounted after image build and may arrive owned
# by root even when the app runs with the default node uid/gid. The standard
# entrypoint only repairs ownership when a uid/gid remap occurs, so proactively
# fix the data directory before handing off to it.
mkdir -p /paperclip

if [ "$(id -u)" -eq 0 ]; then
    chown -R node:node /paperclip
fi

exec docker-entrypoint.sh "$@"
