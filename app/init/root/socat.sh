#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

mkdir -p /tmp/start/nzb

for ONION in $ONIONPROXY
do
    IFS=":" read -r -a DEF <<< "$ONION"
    DOMAIN=${DEF[0]}
    RPORT=${DEF[1]}
    SPORT=${DEF[2]}

cat <<EOT > "/tmp/start/nzb/${DOMAIN}_${RPORT}.sh"
#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

exec socat tcp4-LISTEN:${SPORT},reuseaddr,fork,keepalive,bind=0.0.0.0 SOCKS4A:localhost:${DOMAIN}:${RPORT},socksport=9050

EOT
    chmod ugo+x "/tmp/start/nzb/${DOMAIN}_${RPORT}.sh"
done

chown nzb:nzb -R /tmp
