FROM ghost-python3

ARG UID=82
ARG GID=82

COPY /app /app/
ADD https://nzbget.net/download/nzbget-latest-bin-linux.run /opt/nzbget-latest-bin-linux.run

RUN apt-add-repository non-free && \
    apt-get update && \
    apt-get -y -q install unrar p7zip libxml2 openssl zlib1g ca-certificates tor socat && \
    chmod ugo+x -R /app/init && \
    chmod ugo+x -R /app/scripts && \
    chmod ugo+x -R /app/start && \
    USER nzb ${UID} nzb ${GID} && \
    mkdir -p /home/tor && \
    mkdir -p /home/nzbget && \
    chown nzb:nzb -R /home/tor && \
    chown nzb:nzb -R /home/nzbget && \
    chmod u+x /opt/nzbget-latest-bin-linux.run && \
    mkdir /opt/nzbget && \
    /opt/nzbget-latest-bin-linux.run --destdir /opt/nzbget

EXPOSE 6789

HEALTHCHECK --interval=60s --timeout=15s CMD curl -sx socks5://localhost:9050 'https://check.torproject.org/' | grep -qm1 Congratulations

VOLUME [ "/home/tor", "/home/nzbget" ]