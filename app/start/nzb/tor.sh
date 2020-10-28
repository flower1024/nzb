#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

exec tor -f /app/torrc
