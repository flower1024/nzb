# nzb
tor socatproxy and nzbget

# docker-compose
```
    nzb:
        image: flower1024/nzb
        restart: unless-stopped
        read_only: true
        ports:
            - 80:80/tcp
            - 6789:6789/tcp
        environment:
            - ONIONPROXY=domain.onion:80:10000
            - SERVER_CONNECTIONS=8
            - SERVER_NAME=Servername
            - SERVER_HOST=host
            - SERVER_PORT=119
            - SERVER_USERNAME=username
            - SERVER_PASSWORD=password
        volumes:
            - /srv/volumes/tor/tor:/home/tor
            - /srv/volumes/tor/nzbget:/home/nzbget
            - /srv/volumes/tor/tmp:/tmp
```
