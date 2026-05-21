#!/usr/bin/env bash

PWSH_VERSION="7.6.1"

if [[ $(uname -m) == "aarch64" ]]; then
  ARCH="arm64"
else
  ARCH="x64"
fi

echo "Installing PowerShell Core $PWSH_VERSION..."

curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v${PWSH_VERSION}/powershell-${PWSH_VERSION}-linux-${ARCH}.tar.gz &> /dev/null
mkdir -p /opt/microsoft/powershell/7
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
rm -f /tmp/powershell.tar.gz
chmod +x /opt/microsoft/powershell/7/pwsh
ln -s /opt/microsoft/powershell/7/pwsh /usr/local/bin/pwsh
