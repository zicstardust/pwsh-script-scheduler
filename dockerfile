FROM debian:13.5-slim

ENV DEBIAN_FRONTEND="noninteractive"
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ENV PUID=1000
ENV PGID=1000
ENV SCHEDULE_INTERVAL=1d
ENV SCRIPT_FILE=/usr/local/src/test_script.ps1

COPY src/*.sh /usr/local/bin/
COPY src/*.ps1 /usr/local/src/

RUN chmod -R +x /usr/local/bin/*.sh; \
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

ENTRYPOINT ["entrypoint.sh"]

CMD ["pwsh", "-ExecutionPolicy", "Bypass", "-NoProfile", "-File", "/usr/local/src/main.ps1"]
