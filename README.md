# PowerShell Core Script Scheduler Container

Execute PowerShell scripts in Linux containers by scheduling the intervals between executions.

PowerShell Core version: Latest Stable

[GitHub](https://github.com/zicstardust/pwsh-script-scheduler)

## Container
### Tags

| Tag | Description |
| :----: | :----: |
| [`latest`](https://github.com/zicstardust/pwsh-script-scheduler/blob/main/dockerfile) | Default Tag |

### Registries
| Registry | Full image name | Description |
| :----: | :----: | :----: |
| [`docker.io`](https://hub.docker.com/r/zicstardust/pwsh-script-scheduler) | `docker.io/zicstardust/pwsh-script-scheduler` | Docker Hub |
| [`ghcr.io`](https://github.com/zicstardust/pwsh-script-scheduler/pkgs/container/pwsh-script-scheduler) | `ghcr.io/zicstardust/pwsh-script-scheduler` | GitHub |


### Supported Architectures

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| amd64 | ✅ | latest |
| arm64 | ✅ | latest |


## Usage
### Compose
``` yml
services:
  pwsh-script-scheduler:
    container_name: pwsh-script-scheduler
    image: docker.io/zicstardust/pwsh-script-scheduler:latest
    restart: unless-stopped
    environment:
      TZ: America/New_York
    volumes:
      - <Script Path>:/data
```

## Environment variables

| variables | Function | Default |
| :----: | --- | --- |
| `TZ` | Set Timezone | |
| `PUID` | Set UID with read permission on log files | `1000` |
| `PGID` | Set GID with read permission on log files | `1000` |
| `SCRIPT_FILE` | Full script path | `/usr/local/src/test_script.ps1`  |
| `WORKING_DIRECTORY` | Specifies the location where the new process should be initiated. | `/home/pwsh`  |
| `SCRIPT_ARGUMENTS` | Script arguments | |
| `SCHEDULE_INTERVAL` | Time to generate a new scan of the log files. Example: `30s`: 30 seconds, `5m`: 5 minutes, `1d`: 1 day, `1w`: 1 week. | `1d` |
| `ADDITIONAL_PACKAGES` | Additional packages (Debian) required for the script, separated by spaces. | |
