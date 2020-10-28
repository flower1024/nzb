#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

exec /opt/nzbget/nzbget -s -c /tmp/nzbget.conf 