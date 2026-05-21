FROM debian:13.5-slim

ENV DEBIAN_FRONTEND="noninteractive"
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ENV PUID=1000
ENV PGID=1000
ENV SCHEDULE_INTERVAL=1d
ENV SCRIPT_FILE=/test_script.ps1


WORKDIR /data

COPY src/entrypoint.sh /entrypoint.sh
COPY src/main.ps1 /main.ps1
COPY src/test_script.ps1 /test_script.ps1
COPY src/install_powershell.sh /install_powershell.sh

RUN chmod +x /entrypoint.sh; \
    chmod +x /install_powershell.sh; \
    \
    apt-get update; \
    apt-get -y --no-install-recommends install \
            ca-certificates \
            gosu \
            curl \
            locales \
            libc6 \
            libgcc-s1 \
            libgssapi-krb5-2 \
            libicu76 \
            libssl3t64 \
            libstdc++6 \
            tzdata \
            zlib1g; \
	apt-get -y autoremove; \
	apt-get -y autoclean; \
	apt-get -y clean; \
	rm -Rf /var/lib/apt/lists/*; \
    \
    sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen;  \
    locale-gen

ENTRYPOINT ["/entrypoint.sh"]

CMD ["pwsh", "-ExecutionPolicy", "Bypass", "-NoProfile", "-File", "/main.ps1"]
