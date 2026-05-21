#!/bin/sh
set -e

/install_powershell.sh

if [ "$(id -g pwsh)" != "${PGID}" ]; then
    groupmod -o -g "${PGID}" pwsh
fi


if [ "$(id -u pwsh)" != "${PUID}" ]; then
    usermod -o -u "${PUID}" pwsh
fi

mkdir -p /home/pwsh /data
chown -R pwsh:pwsh /home/pwsh /data

exec su-exec pwsh "$@"