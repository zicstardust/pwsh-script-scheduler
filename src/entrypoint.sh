#/usr/bin/bash
set -e

echo "Installing PowerShell Core..."
/install_powershell.sh 1> /dev/null

: "${PUID:=1000}"
: "${PGID:=1000}"

if ! getent group pwsh >/dev/null; then
    groupadd -g "$PGID" pwsh
fi

if ! id -u pwsh >/dev/null 2>&1; then
    useradd -m -u "$PUID" -g "$PGID" -s /sbin/nologin pwsh
fi

mkdir -p /data /home/pwsh

chown -R pwsh:pwsh /data /home/pwsh

exec gosu pwsh "$@"