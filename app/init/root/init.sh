#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

cp /app/conf/nzbget.conf /tmp/nzbget.conf
sed -i 's|\(^Server1\.Name=\).*|\1'"${SERVER_NAME}"'|;' /tmp/nzbget.conf
sed -i 's|\(^Server1\.Port=\).*|\1'"${SERVER_PORT}"'|;' /tmp/nzbget.conf
sed -i 's|\(^Server1\.Host=\).*|\1'"${SERVER_HOST}"'|;' /tmp/nzbget.conf
sed -i 's|\(^Server1\.Username=\).*|\1'"${SERVER_USERNAME}"'|;' /tmp/nzbget.conf
sed -i 's|\(^Server1\.Password=\).*|\1'"${SERVER_PASSWORD}"'|;' /tmp/nzbget.conf
sed -i 's|\(^Server1\.Connections=\).*|\1'"${SERVER_CONNECTIONS}"'|;' /tmp/nzbget.conf
sed -i 's|\(^MainDir=\).*|\1/home/nzbget|;' /tmp/nzbget.conf
sed -i 's|\(^DaemonUsername=\).*|\1nzb|;' /tmp/nzbget.conf
sed -i 's|\(^WebDir=\).*|\1/opt/nzbget/webui|;' /tmp/nzbget.conf

[[ ! -d /home/nzbget/.scripts ]] && mkdir -p /home/nzbget/.scripts
cp /app/scripts/* /home/nzbget/.scripts
chown nzb:nzb /home/nzbget

